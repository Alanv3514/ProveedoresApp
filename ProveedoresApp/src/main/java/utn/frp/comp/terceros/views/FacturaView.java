package utn.frp.comp.terceros.views;

import utn.frp.comp.terceros.model.Factura;
import utn.frp.comp.terceros.model.Item;
import utn.frp.comp.terceros.model.Tercero;
import utn.frp.comp.terceros.repositorios.FacturaRepository;
import utn.frp.comp.terceros.repositorios.TerceroRepository;
import utn.frp.comp.terceros.ui.MainLayout;

import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.button.ButtonVariant;
import com.vaadin.flow.component.combobox.ComboBox;
import com.vaadin.flow.component.confirmdialog.ConfirmDialog;
import com.vaadin.flow.component.dialog.Dialog;
import com.vaadin.flow.component.formlayout.FormLayout;
import com.vaadin.flow.component.grid.Grid;
import com.vaadin.flow.component.html.H2;
import com.vaadin.flow.component.icon.VaadinIcon;
import com.vaadin.flow.component.notification.Notification;
import com.vaadin.flow.component.notification.NotificationVariant;
import com.vaadin.flow.component.orderedlayout.HorizontalLayout;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.component.textfield.BigDecimalField;
import com.vaadin.flow.component.textfield.IntegerField;
import com.vaadin.flow.component.textfield.TextField;
import com.vaadin.flow.data.binder.BeanValidationBinder;
import com.vaadin.flow.router.Menu;
import com.vaadin.flow.router.Route;

import java.util.ArrayList;

@Route(value = "factura", layout = MainLayout.class)
@Menu(title = "Facturas", order = 3, icon = "vaadin:file-text")
public class FacturaView extends VerticalLayout {

	private final FacturaRepository repository;
	private final TerceroRepository terceroRepository;
	private final Grid<Factura> grid = new Grid<>(Factura.class);
	private final BeanValidationBinder<Factura> binder = new BeanValidationBinder<>(Factura.class);
	private Factura actual;

	public FacturaView(FacturaRepository repository, TerceroRepository terceroRepository) {
		this.repository = repository;
		this.terceroRepository = terceroRepository;
		setSizeFull();

		add(new H2("Facturas"), crearToolbar(), grid);
		configurarGrilla();
		refrescarGrilla();
	}

	private HorizontalLayout crearToolbar() {
		var nuevo = new Button("Nuevo", VaadinIcon.PLUS.create(), e -> {
			var f = new Factura();
			f.setListaItems(new ArrayList<>());
			abrirEditor(f);
		});
		var refresh = new Button("Actualizar", VaadinIcon.REFRESH.create(), e -> refrescarGrilla());
		return new HorizontalLayout(nuevo, refresh);
	}

	private void configurarGrilla() {
		grid.removeAllColumns();
		grid.addColumn(Factura::getNumero).setHeader("Número").setAutoWidth(true).setSortable(true);
		grid.addColumn(f -> f.getTercero() != null ? f.getTercero().getNombre() + " (" + f.getTercero().getCuit() + ")" : "").setHeader("Tercero").setAutoWidth(true).setSortable(true);
		grid.addColumn(Factura::getFecha).setHeader("Fecha").setAutoWidth(true).setSortable(true);
		grid.addComponentColumn(factura -> {
			var edit = new Button(VaadinIcon.EDIT.create(), e -> abrirEditor(factura));
			var del = new Button(VaadinIcon.TRASH.create(), e -> eliminar(factura));
			del.addThemeVariants(ButtonVariant.LUMO_ERROR);
			return new HorizontalLayout(edit, del);
		}).setHeader("Acciones").setAutoWidth(true);
	}

	private void refrescarGrilla() {
		grid.setItems(repository.findAll());
	}

	private void abrirEditor(Factura factura) {
		actual = factura;
		var dialog = new Dialog();
		dialog.setHeaderTitle(factura.getId() != null ? "Editar Factura" : "Nueva Factura");
		dialog.setWidth("700px");
		dialog.setHeight("80vh");

		var numero = new IntegerField("Número");
		var terceroCb = new ComboBox<Tercero>("Tercero");
		terceroCb.setItems(terceroRepository.findAll());
		terceroCb.setItemLabelGenerator(t -> t.getNombre() + " (" + t.getCuit() + ")");

		FormLayout form = new FormLayout(numero, terceroCb);
		form.setResponsiveSteps(new FormLayout.ResponsiveStep("0", 2));

		binder.forField(numero).bind("numero");
		binder.forField(terceroCb).asRequired("El tercero es obligatorio").bind("tercero");
		binder.readBean(actual);

		var itemsGrid = new Grid<>(Item.class, false);
		itemsGrid.setHeight("200px");

		itemsGrid.addComponentColumn(item -> {
			var detalleField = new TextField();
			detalleField.setValue(item.getDetalle() != null ? item.getDetalle() : "");
			detalleField.addValueChangeListener(ev -> item.setDetalle(ev.getValue()));
			return detalleField;
		}).setHeader("Detalle").setAutoWidth(true);

		itemsGrid.addComponentColumn(item -> {
			var cantidadField = new BigDecimalField();
			cantidadField.setValue(item.getCantidad());
			cantidadField.addValueChangeListener(ev -> item.setCantidad(ev.getValue()));
			return cantidadField;
		}).setHeader("Cantidad").setAutoWidth(true);

		itemsGrid.addComponentColumn(item -> {
			var montoField = new BigDecimalField();
			montoField.setValue(item.getMonto());
			montoField.addValueChangeListener(ev -> item.setMonto(ev.getValue()));
			return montoField;
		}).setHeader("Monto").setAutoWidth(true);

		itemsGrid.addComponentColumn(item -> {
			var del = new Button(VaadinIcon.TRASH.create(), ev -> {
				if (actual.getListaItems() != null) {
					actual.getListaItems().remove(item);
					item.setFactura(null);
					itemsGrid.setItems(actual.getListaItems());
				}
			});
			del.addThemeVariants(ButtonVariant.LUMO_ERROR, ButtonVariant.LUMO_SMALL);
			return del;
		}).setHeader("").setAutoWidth(true);

		var btnAgregarItem = new Button("Agregar Item", VaadinIcon.PLUS.create(), e -> {
			var nuevoItem = new Item();
			if (actual.getListaItems() == null) {
				actual.setListaItems(new ArrayList<>());
			}
			actual.addItem(nuevoItem);
			itemsGrid.setItems(actual.getListaItems());
		});

		itemsGrid.setItems(actual.getListaItems() != null ? actual.getListaItems() : new ArrayList<>());

		var guardar = new Button("Guardar", e -> confirmarGuardar(dialog));
		guardar.addThemeVariants(ButtonVariant.LUMO_PRIMARY);

		var cancelar = new Button("Cancelar", e -> dialog.close());

		var content = new VerticalLayout(form, new H2("Items"), btnAgregarItem, itemsGrid);
		content.setPadding(false);
		dialog.add(content);
		dialog.getFooter().add(guardar, cancelar);
		dialog.open();
	}

	private void eliminar(Factura factura) {
		var confirmDialog = new ConfirmDialog();
		confirmDialog.setHeader("Confirmar eliminación");
		confirmDialog.setText("¿Está seguro de que desea eliminar la factura N° " + factura.getNumero() + "?");
		confirmDialog.setConfirmText("Eliminar");
		confirmDialog.setCancelText("Cancelar");
		confirmDialog.setCancelable(true);
		confirmDialog.setConfirmButtonTheme("error primary");
		confirmDialog.addConfirmListener(e -> {
			repository.delete(factura);
			refrescarGrilla();
			Notification.show("Factura eliminada");
		});
		confirmDialog.open();
	}

	private void confirmarGuardar(Dialog dialog) {
		var confirmDialog = new ConfirmDialog();
		confirmDialog.setHeader("Confirmar cambios");
		confirmDialog.setText("¿Está seguro de que desea guardar los cambios?");
		confirmDialog.setConfirmText("Guardar");
		confirmDialog.setCancelText("Cancelar");
		confirmDialog.setCancelable(true);
		confirmDialog.setConfirmButtonTheme("primary");
		confirmDialog.addConfirmListener(e -> {
			if (binder.writeBeanIfValid(actual)) {
				if (actual.getListaItems() == null || actual.getListaItems().isEmpty()) {
					Notification.show("Debe agregar al menos un item a la factura");
					return;
				}
				try {
					boolean esNuevo = actual.getId() == null;
					repository.save(actual);
					refrescarGrilla();
					dialog.close();
					var notif = Notification.show(esNuevo ? "Factura creada" : "Factura modificada", 3000, Notification.Position.MIDDLE);
					notif.addThemeVariants(NotificationVariant.LUMO_SUCCESS);
				} catch (Exception ex) {
					Notification.show("Error al guardar: " + ex.getMessage());
				}
			}
		});
		confirmDialog.open();
	}
}
