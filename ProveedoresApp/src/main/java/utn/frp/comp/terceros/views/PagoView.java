package utn.frp.comp.terceros.views;

import utn.frp.comp.terceros.model.Pago;
import utn.frp.comp.terceros.model.PagoDetalle;
import utn.frp.comp.terceros.model.Tercero;
import utn.frp.comp.terceros.repositorios.PagoRepository;
import utn.frp.comp.terceros.repositorios.TerceroRepository;
import utn.frp.comp.terceros.ui.MainLayout;

import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.button.ButtonVariant;
import com.vaadin.flow.component.checkbox.Checkbox;
import com.vaadin.flow.component.combobox.ComboBox;
import com.vaadin.flow.component.confirmdialog.ConfirmDialog;
import com.vaadin.flow.component.datepicker.DatePicker;
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
import com.vaadin.flow.component.textfield.TextField;
import com.vaadin.flow.data.binder.BeanValidationBinder;
import com.vaadin.flow.router.Menu;
import com.vaadin.flow.router.Route;

import java.util.ArrayList;

@Route(value = "pago", layout = MainLayout.class)
@Menu(title = "Pagos", order = 4, icon = "vaadin:money")
public class PagoView extends VerticalLayout {

	private final PagoRepository repository;
	private final TerceroRepository terceroRepository;
	private final Grid<Pago> grid = new Grid<>(Pago.class);
	private final BeanValidationBinder<Pago> binder = new BeanValidationBinder<>(Pago.class);
	private Pago actual;

	public PagoView(PagoRepository repository, TerceroRepository terceroRepository) {
		this.repository = repository;
		this.terceroRepository = terceroRepository;
		setSizeFull();

		add(new H2("Pagos"), crearToolbar(), grid);
		configurarGrilla();
		refrescarGrilla();
		//<theme-editor-local-classname>
		addClassName("pago-view-vertical-layout-1");
	}

	private HorizontalLayout crearToolbar() {
		var nuevo = new Button("Nuevo", VaadinIcon.PLUS.create(), e -> {
			var p = new Pago();
			p.setListaDetalles(new ArrayList<>());
			abrirEditor(p);
		});
		var refresh = new Button("Actualizar", VaadinIcon.REFRESH.create(), e -> refrescarGrilla());
		return new HorizontalLayout(nuevo, refresh);
	}

	private void configurarGrilla() {
		grid.removeAllColumns();
		grid.addColumn(p -> p.getTercero() != null ? p.getTercero().getNombre() + " (" + p.getTercero().getCuit() + ")" : "").setHeader("Tercero").setAutoWidth(true).setSortable(true);
		grid.addColumn(Pago::getFechaPago).setHeader("Fecha Pago").setAutoWidth(true).setSortable(true);
		grid.addColumn(Pago::getMontoPago).setHeader("Monto").setAutoWidth(true).setSortable(true);
		grid.addColumn(Pago::getModoPago).setHeader("Modo Pago").setAutoWidth(true).setSortable(true);
		grid.addComponentColumn(pago -> {
			var edit = new Button(VaadinIcon.EDIT.create(), e -> abrirEditor(pago));
			var del = new Button(VaadinIcon.TRASH.create(), e -> eliminar(pago));
			del.addThemeVariants(ButtonVariant.LUMO_ERROR);
			return new HorizontalLayout(edit, del);
		}).setHeader("Acciones").setAutoWidth(true);
	}

	private void refrescarGrilla() {
		grid.setItems(repository.findAll());
	}

	private void abrirEditor(Pago pago) {
		actual = pago;
		var dialog = new Dialog();
		dialog.setHeaderTitle(pago.getId() != null ? "Editar Pago" : "Nuevo Pago");
		dialog.setWidth("700px");
		dialog.setHeight("80vh");

		var terceroCb = new ComboBox<Tercero>("Tercero");
		terceroCb.setItems(terceroRepository.findAll());
		terceroCb.setItemLabelGenerator(t -> t.getNombre() + " (" + t.getCuit() + ")");

		var fechaPago = new DatePicker("Fecha Pago");
		var montoPago = new BigDecimalField("Monto Pago");
		var modoPago = new TextField("Modo Pago");

		FormLayout form = new FormLayout(terceroCb, fechaPago, montoPago, modoPago);
		form.setResponsiveSteps(new FormLayout.ResponsiveStep("0", 2));

		binder.forField(terceroCb).asRequired("El tercero es obligatorio").bind("tercero");
		binder.forField(fechaPago).bind("fechaPago");
		binder.forField(montoPago).bind("montoPago");
		binder.forField(modoPago).bind("modoPago");
		binder.readBean(actual);

		var detallesGrid = new Grid<>(PagoDetalle.class, false);
		detallesGrid.setHeight("200px");

		detallesGrid.addComponentColumn(det -> {
			var numField = new TextField();
			numField.setValue(det.getNumeroInstrumento() != null ? det.getNumeroInstrumento() : "");
			numField.addValueChangeListener(ev -> det.setNumeroInstrumento(ev.getValue()));
			return numField;
		}).setHeader("Instrumento Nro").setAutoWidth(true);

		detallesGrid.addComponentColumn(det -> {
			var fechaField = new DatePicker();
			fechaField.setValue(det.getFechaInstrumento());
			fechaField.addValueChangeListener(ev -> det.setFechaInstrumento(ev.getValue()));
			return fechaField;
		}).setHeader("Fecha Instrumento").setAutoWidth(true);

		detallesGrid.addComponentColumn(det -> {
			var bancoField = new TextField();
			bancoField.setValue(det.getBanco() != null ? det.getBanco() : "");
			bancoField.addValueChangeListener(ev -> det.setBanco(ev.getValue()));
			return bancoField;
		}).setHeader("Banco").setAutoWidth(true);

		detallesGrid.addComponentColumn(det -> {
			var pagoRealizadoCb = new Checkbox();
			pagoRealizadoCb.setValue(det.getPagoRealizado() != null ? det.getPagoRealizado() : false);
			pagoRealizadoCb.addValueChangeListener(ev -> det.setPagoRealizado(ev.getValue()));
			return pagoRealizadoCb;
		}).setHeader("Pago Realizado").setAutoWidth(true);

		detallesGrid.addComponentColumn(det -> {
			var del = new Button(VaadinIcon.TRASH.create(), ev -> {
				if (actual.getListaDetalles() != null) {
					actual.getListaDetalles().remove(det);
					det.setPago(null);
					detallesGrid.setItems(actual.getListaDetalles());
				}
			});
			del.addThemeVariants(ButtonVariant.LUMO_ERROR, ButtonVariant.LUMO_SMALL);
			return del;
		}).setHeader("").setAutoWidth(true);

		var btnAgregarDetalle = new Button("Agregar Detalle", VaadinIcon.PLUS.create(), e -> {
			var nuevoDet = new PagoDetalle();
			if (actual.getListaDetalles() == null) {
				actual.setListaDetalles(new ArrayList<>());
			}
			nuevoDet.setPago(actual);
			actual.getListaDetalles().add(nuevoDet);
			detallesGrid.setItems(actual.getListaDetalles());
		});

		detallesGrid.setItems(actual.getListaDetalles() != null ? actual.getListaDetalles() : new ArrayList<>());

		var guardar = new Button("Guardar", e -> confirmarGuardar(dialog));
		guardar.addThemeVariants(ButtonVariant.LUMO_PRIMARY);

		var cancelar = new Button("Cancelar", e -> dialog.close());

		var content = new VerticalLayout(form, new H2("Detalles"), btnAgregarDetalle, detallesGrid);
		content.setPadding(false);
		dialog.add(content);
		dialog.getFooter().add(guardar, cancelar);
		dialog.open();
	}

	private void eliminar(Pago pago) {
		var confirmDialog = new ConfirmDialog();
		confirmDialog.setHeader("Confirmar eliminación");
		confirmDialog.setText("¿Está seguro de que desea eliminar este pago?");
		confirmDialog.setConfirmText("Eliminar");
		confirmDialog.setCancelText("Cancelar");
		confirmDialog.setCancelable(true);
		confirmDialog.setConfirmButtonTheme("error primary");
		confirmDialog.addConfirmListener(e -> {
			repository.delete(pago);
			refrescarGrilla();
			Notification.show("Pago eliminado");
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
				if (actual.getListaDetalles() == null || actual.getListaDetalles().isEmpty()) {
					Notification.show("Debe agregar al menos un detalle al pago");
					return;
				}
				try {
					boolean esNuevo = actual.getId() == null;
					repository.save(actual);
					refrescarGrilla();
					dialog.close();
					var notif = Notification.show(esNuevo ? "Pago creado" : "Pago modificado", 3000, Notification.Position.MIDDLE);
					notif.addThemeVariants(NotificationVariant.LUMO_SUCCESS);
				} catch (Exception ex) {
					Notification.show("Error al guardar: " + ex.getMessage());
				}
			}
		});
		confirmDialog.open();
	}
}
