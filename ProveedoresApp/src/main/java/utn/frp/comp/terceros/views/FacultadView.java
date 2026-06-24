package utn.frp.comp.terceros.views;

import utn.frp.comp.terceros.model.Facultad;
import utn.frp.comp.terceros.repositorios.FacultadRepository;
import utn.frp.comp.terceros.ui.MainLayout;

import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.button.ButtonVariant;
import com.vaadin.flow.component.checkbox.Checkbox;
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
import com.vaadin.flow.component.textfield.IntegerField;
import com.vaadin.flow.component.textfield.TextField;
import com.vaadin.flow.data.binder.BeanValidationBinder;
import com.vaadin.flow.router.Menu;
import com.vaadin.flow.router.Route;

@Route(value = "facultad", layout = MainLayout.class)
@Menu(title = "Facultades", order = 1, icon = "vaadin:building")
public class FacultadView extends VerticalLayout {

	private final FacultadRepository repository;
	private final Grid<Facultad> grid = new Grid<>(Facultad.class);
	private final BeanValidationBinder<Facultad> binder = new BeanValidationBinder<>(Facultad.class);
	private Facultad actual;

	public FacultadView(FacultadRepository repository) {
		this.repository = repository;
		setSizeFull();

		add(new H2("Facultades"), crearToolbar(), grid);
		configurarGrilla();
		refrescarGrilla();
	}

	private HorizontalLayout crearToolbar() {
		var nuevo = new Button("Nuevo", VaadinIcon.PLUS.create(), e -> abrirEditor(new Facultad()));
		var refresh = new Button("Actualizar", VaadinIcon.REFRESH.create(), e -> refrescarGrilla());
		return new HorizontalLayout(nuevo, refresh);
	}

	private void configurarGrilla() {
		grid.setColumns("nombre", "direccion", "cuit", "sucursal", "telefonos", "correo", "defecto");
		grid.addComponentColumn(facultad -> {
			var edit = new Button(VaadinIcon.EDIT.create(), e -> abrirEditor(facultad));
			var del = new Button(VaadinIcon.TRASH.create(), e -> eliminar(facultad));
			del.addThemeVariants(ButtonVariant.LUMO_ERROR);
			return new HorizontalLayout(edit, del);
		}).setHeader("Acciones").setAutoWidth(true);
		grid.getColumns().forEach(c -> c.setAutoWidth(true));
	}

	private void refrescarGrilla() {
		grid.setItems(repository.findAll());
	}

	private void abrirEditor(Facultad facultad) {
		actual = facultad;
		var dialog = new Dialog();
		dialog.setHeaderTitle(facultad.getId() != null ? "Editar Facultad" : "Nueva Facultad");

		var nombre = new TextField("Nombre");
		var direccion = new TextField("Dirección");
		var cuit = new TextField("CUIT");
		var sucursal = new IntegerField("Sucursal");
		var telefonos = new TextField("Teléfonos");
		var correo = new TextField("Email");
		var defecto = new Checkbox("Defecto");

		FormLayout form = new FormLayout(nombre, direccion, cuit, sucursal, telefonos, correo, defecto);
		form.setResponsiveSteps(new FormLayout.ResponsiveStep("0", 2));

		binder.forField(nombre).bind("nombre");
		binder.forField(direccion).bind("direccion");
		binder.forField(cuit).bind("cuit");
		binder.forField(sucursal).bind("sucursal");
		binder.forField(telefonos).bind("telefonos");
		binder.forField(correo).bind("correo");
		binder.forField(defecto).bind("defecto");
		binder.readBean(actual);

		var guardar = new Button("Guardar", e -> confirmarGuardar(dialog));
		guardar.addThemeVariants(ButtonVariant.LUMO_PRIMARY);

		var cancelar = new Button("Cancelar", e -> dialog.close());

		dialog.add(form);
		dialog.getFooter().add(guardar, cancelar);
		dialog.open();
	}

	private void eliminar(Facultad facultad) {
		var confirmDialog = new ConfirmDialog();
		confirmDialog.setHeader("Confirmar eliminación");
		confirmDialog.setText("¿Está seguro de que desea eliminar la facultad \"" + facultad.getNombre() + "\"?");
		confirmDialog.setConfirmText("Eliminar");
		confirmDialog.setCancelText("Cancelar");
		confirmDialog.setCancelable(true);
		confirmDialog.setConfirmButtonTheme("error primary");
		confirmDialog.addConfirmListener(e -> {
			repository.delete(facultad);
			refrescarGrilla();
			Notification.show("Facultad eliminada");
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
				var notif = Notification.show(esNuevo ? "Facultad creada" : "Facultad modificada", 3000, Notification.Position.MIDDLE);
				notif.addThemeVariants(NotificationVariant.LUMO_SUCCESS);
			}
		});
		confirmDialog.open();
	}
}
