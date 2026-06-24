package utn.frp.comp.terceros.views;

import com.vaadin.flow.component.UI;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.button.ButtonVariant;
import com.vaadin.flow.component.html.H1;
import com.vaadin.flow.component.notification.Notification;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.component.textfield.PasswordField;
import com.vaadin.flow.component.textfield.TextField;
import com.vaadin.flow.router.BeforeEnterEvent;
import com.vaadin.flow.router.BeforeEnterObserver;
import com.vaadin.flow.router.PageTitle;
import com.vaadin.flow.router.Route;

import utn.frp.comp.terceros.model.Usuario;
import utn.frp.comp.terceros.seguridad.SeguridadUtils;
import utn.frp.comp.terceros.servicios.UsuarioService;

@Route("login")
@PageTitle("Iniciar Sesión")
public class LoginView extends VerticalLayout implements BeforeEnterObserver {

	private final UsuarioService usuarioService;
	private final TextField username = new TextField("Usuario");
	private final PasswordField password = new PasswordField("Contraseña");
	private final Button loginButton = new Button("Ingresar");
	private final Button registerButton = new Button("Registrarse");

	public LoginView(UsuarioService usuarioService) {
		this.usuarioService = usuarioService;

		addClassName("login-view");
		setSizeFull();
		setAlignItems(Alignment.CENTER);
		setJustifyContentMode(JustifyContentMode.CENTER);

		username.setWidth("300px");
		password.setWidth("300px");
		loginButton.addThemeVariants(ButtonVariant.LUMO_PRIMARY);
		loginButton.setWidth("300px");
		registerButton.setWidth("300px");

		loginButton.addClickListener(e -> autenticar());
		registerButton.addClickListener(e -> UI.getCurrent().navigate("register"));
		password.addKeyPressListener(e -> {
			if ("Enter".equals(e.getKey())) {
				autenticar();
			}
		});

		add(new H1("Sistema de Terceros"), username, password, loginButton, registerButton);
	}

	private void autenticar() {
		var resultado = usuarioService.login(username.getValue(), password.getValue());
		if (resultado.isPresent()) {
			Usuario usuario = resultado.get();
			SeguridadUtils.iniciarSesion(usuario);
			UI.getCurrent().navigate("/");
		} else {
			Notification.show("Usuario o contraseña incorrectos", 3000, Notification.Position.MIDDLE);
			password.clear();
		}
	}

	@Override
	public void beforeEnter(BeforeEnterEvent event) {
	}
}
