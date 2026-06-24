package utn.frp.comp.terceros.seguridad;

import com.vaadin.flow.server.VaadinSession;

import utn.frp.comp.terceros.model.Usuario;

public class SeguridadUtils {

	private static final String ATRIBUTO_USUARIO = "usuario";

	public static boolean estaAutenticado() {
		return VaadinSession.getCurrent() != null
				&& VaadinSession.getCurrent().getAttribute(ATRIBUTO_USUARIO) != null;
	}

	public static void iniciarSesion(Usuario usuario) {
		VaadinSession.getCurrent().setAttribute(ATRIBUTO_USUARIO, usuario);
	}

	public static void cerrarSesion() {
		VaadinSession.getCurrent().close();
	}

	public static Usuario getUsuarioActual() {
		return (Usuario) VaadinSession.getCurrent().getAttribute(ATRIBUTO_USUARIO);
	}
}
