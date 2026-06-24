package utn.frp.comp.terceros.seguridad;

import org.springframework.stereotype.Component;

import com.vaadin.flow.router.BeforeEnterEvent;
import com.vaadin.flow.server.ServiceInitEvent;
import com.vaadin.flow.server.VaadinServiceInitListener;

import utn.frp.comp.terceros.views.LoginView;
import utn.frp.comp.terceros.views.RegisterView;

@Component
public class ConfigurarInicioUIListener implements VaadinServiceInitListener {

	@Override
	public void serviceInit(ServiceInitEvent event) {
		event.getSource().addUIInitListener(uiEvent -> {
			uiEvent.getUI().addBeforeEnterListener(this::autenticarNavegacion);
		});
	}

	private void autenticarNavegacion(BeforeEnterEvent event) {
		if (!SeguridadUtils.estaAutenticado()
				&& !LoginView.class.equals(event.getNavigationTarget())
				&& !RegisterView.class.equals(event.getNavigationTarget())) {
			event.rerouteTo(LoginView.class);
		}
	}
}
