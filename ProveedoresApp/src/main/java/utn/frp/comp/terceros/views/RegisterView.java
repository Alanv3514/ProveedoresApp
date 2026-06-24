package utn.frp.comp.terceros.views;

import com.vaadin.flow.component.UI;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.button.ButtonVariant;
import com.vaadin.flow.component.html.H1;
import com.vaadin.flow.component.notification.Notification;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.component.textfield.PasswordField;
import com.vaadin.flow.component.textfield.TextField;
import com.vaadin.flow.router.PageTitle;
import com.vaadin.flow.router.Route;

import utn.frp.comp.terceros.servicios.UsuarioService;

@Route("register")
@PageTitle("Registro")
public class RegisterView extends VerticalLayout {

	private final UsuarioService usuarioService;
	private final TextField username = new TextField("Usuario");
	private final PasswordField password = new PasswordField("Contraseña");
	private final PasswordField confirmarPassword = new PasswordField("Reingresar Contraseña");
	private final Button registerButton = new Button("Registrarse");
	private final Button backButton = new Button("Volver al Login");

	public RegisterView(UsuarioService usuarioService) {
		this.usuarioService = usuarioService;

		setSizeFull();
		setAlignItems(Alignment.CENTER);
		setJustifyContentMode(JustifyContentMode.CENTER);

		username.setWidth("300px");
		password.setWidth("300px");
		confirmarPassword.setWidth("300px");
		registerButton.addThemeVariants(ButtonVariant.LUMO_PRIMARY);
		registerButton.setWidth("300px");
		backButton.setWidth("300px");

		registerButton.addClickListener(e -> registrar());
		backButton.addClickListener(e -> UI.getCurrent().navigate("login"));

		add(new H1("Registro de Usuario"), username, password, confirmarPassword, registerButton, backButton);
	}

	private void registrar() {
		String user = username.getValue().trim();
		String pass = password.getValue();
		String confirm = confirmarPassword.getValue();

		if (user.isEmpty() || pass.isEmpty()) {
			Notification.show("Todos los campos son obligatorios", 3000, Notification.Position.MIDDLE);
			return;
		}

		if (!pass.equals(confirm)) {
			Notification.show("Las contraseñas no coinciden", 3000, Notification.Position.MIDDLE);
			return;
		}

		try {
			usuarioService.registrarUsuario(user, pass);
			Notification.show("Usuario registrado correctamente", 3000, Notification.Position.MIDDLE);
			UI.getCurrent().navigate("login");
		} catch (IllegalArgumentException ex) {
			Notification.show(ex.getMessage(), 3000, Notification.Position.MIDDLE);
		}
	}
}
