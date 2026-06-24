package utn.frp.comp.terceros.views;

import utn.frp.comp.terceros.model.Tercero;
import utn.frp.comp.terceros.model.Tercero.SituacionIVA;
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
import com.vaadin.flow.component.textfield.TextField;
import com.vaadin.flow.data.binder.BeanValidationBinder;
import com.vaadin.flow.router.Menu;
import com.vaadin.flow.router.Route;

@Route(value = "tercero", layout = MainLayout.class)
@Menu(title = "Terceros", order = 2, icon = "vaadin:users")
public class TerceroView extends VerticalLayout {

	private final TerceroRepository repository;
	private final Grid<Tercero> grid = new Grid<>(Tercero.class);
	private final BeanValidationBinder<Tercero> binder = new BeanValidationBinder<>(Tercero.class);
	private Tercero actual;

	public TerceroView(TerceroRepository repository) {
		this.repository = repository;
		setSizeFull();

		add(new H2("Terceros"), crearToolbar(), grid);
		configurarGrilla();
		refrescarGrilla();
	}

	private HorizontalLayout crearToolbar() {
		var nuevo = new Button("Nuevo", VaadinIcon.PLUS.create(), e -> abrirEditor(new Tercero()));
		var refresh = new Button("Actualizar", VaadinIcon.REFRESH.create(), e -> refrescarGrilla());
		return new HorizontalLayout(nuevo, refresh);
	}

	private void configurarGrilla() {
		grid.removeAllColumns();
		grid.addColumn(Tercero::getNombre).setHeader("Nombre").setAutoWidth(true).setSortable(true);
		grid.addColumn(Tercero::getCuit).setHeader("CUIT").setAutoWidth(true).setSortable(true);
		grid.addColumn(t -> t.getSitiva() != null ? t.getSitiva().getDescripcion() : "").setHeader("Situación IVA").setAutoWidth(true).setSortable(true);
		grid.addColumn(Tercero::getDireccion).setHeader("Dirección").setAutoWidth(true).setSortable(true);
		grid.addColumn(Tercero::getLocalidad).setHeader("Localidad").setAutoWidth(true).setSortable(true);
		grid.addColumn(Tercero::getProvincia).setHeader("Provincia").setAutoWidth(true).setSortable(true);
		grid.addColumn(Tercero::getTelefonos).setHeader("Teléfonos").setAutoWidth(true).setSortable(true);
		grid.addColumn(Tercero::getSaldoApertura).setHeader("Saldo Apertura").setAutoWidth(true).setSortable(true);
		grid.addColumn(Tercero::getTipoSaldo).setHeader("Tipo Saldo").setAutoWidth(true).setSortable(true);
		grid.addComponentColumn(tercero -> {
			var edit = new Button(VaadinIcon.EDIT.create(), e -> abrirEditor(tercero));
			var del = new Button(VaadinIcon.TRASH.create(), e -> eliminar(tercero));
			del.addThemeVariants(ButtonVariant.LUMO_ERROR);
			return new HorizontalLayout(edit, del);
		}).setHeader("Acciones").setAutoWidth(true);
	}

	private void refrescarGrilla() {
		grid.setItems(repository.findAll());
	}

	private void abrirEditor(Tercero tercero) {
		actual = tercero;
		var dialog = new Dialog();
		dialog.setHeaderTitle(tercero.getId() != null ? "Editar Tercero" : "Nuevo Tercero");

		var nombre = new TextField("Nombre");
		var cuit = new TextField("CUIT");
		var sitiva = new ComboBox<SituacionIVA>("Situación IVA");
		sitiva.setItems(SituacionIVA.values());
		sitiva.setItemLabelGenerator(SituacionIVA::getDescripcion);
		var direccion = new TextField("Dirección");
		var localidad = new TextField("Localidad");
		var provincia = new TextField("Provincia");
		var telefonos = new TextField("Teléfonos");
		var saldoApertura = new BigDecimalField("Saldo Apertura");
		var tipoSaldo = new TextField("Tipo Saldo");

		FormLayout form = new FormLayout(nombre, cuit, sitiva, direccion, localidad, provincia, telefonos, saldoApertura, tipoSaldo);
		form.setResponsiveSteps(new FormLayout.ResponsiveStep("0", 2));

		binder.forField(nombre).bind("nombre");
		binder.forField(cuit).bind("cuit");
		binder.forField(sitiva).asRequired("La situación IVA es obligatoria").bind("sitiva");
		binder.forField(direccion).bind("direccion");
		binder.forField(localidad).bind("localidad");
		binder.forField(provincia).bind("provincia");
		binder.forField(telefonos).bind("telefonos");
		binder.forField(saldoApertura).bind("saldoApertura");
		binder.forField(tipoSaldo).bind("tipoSaldo");
		binder.readBean(actual);

		var guardar = new Button("Guardar", e -> confirmarGuardar(dialog));
		guardar.addThemeVariants(ButtonVariant.LUMO_PRIMARY);

		var cancelar = new Button("Cancelar", e -> dialog.close());

		dialog.add(form);
		dialog.getFooter().add(guardar, cancelar);
		dialog.open();
	}

	private void eliminar(Tercero tercero) {
		var confirmDialog = new ConfirmDialog();
		confirmDialog.setHeader("Confirmar eliminación");
		confirmDialog.setText("¿Está seguro de que desea eliminar el tercero \"" + tercero.getNombre() + "\"?");
		confirmDialog.setConfirmText("Eliminar");
		confirmDialog.setCancelText("Cancelar");
		confirmDialog.setCancelable(true);
		confirmDialog.setConfirmButtonTheme("error primary");
		confirmDialog.addConfirmListener(e -> {
			try {
				repository.delete(tercero);
				refrescarGrilla();
				Notification.show("Tercero eliminado");
			} catch (Exception ex) {
				Notification.show("Error al eliminar: " + ex.getMessage());
			}
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
				boolean esNuevo = actual.getId() == null;
				repository.save(actual);
				refrescarGrilla();
				dialog.close();
				var notif = Notification.show(esNuevo ? "Tercero creado" : "Tercero modificado", 3000, Notification.Position.MIDDLE);
				notif.addThemeVariants(NotificationVariant.LUMO_SUCCESS);
			}
		});
		confirmDialog.open();
	}
}
