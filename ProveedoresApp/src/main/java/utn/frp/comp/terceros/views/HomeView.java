package utn.frp.comp.terceros.views;

import com.vaadin.flow.component.html.H1;
import com.vaadin.flow.component.html.Paragraph;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.router.Menu;
import com.vaadin.flow.router.Route;

import utn.frp.comp.terceros.ui.MainLayout;

@Route(value = "", layout = MainLayout.class)
@Menu(title = "Inicio", order = 0, icon = "vaadin:home")
public class HomeView extends VerticalLayout {

	public HomeView() {
		setSizeFull();
		setAlignItems(Alignment.CENTER);
		setJustifyContentMode(JustifyContentMode.CENTER);

		add(new H1("Terceros"), new Paragraph("Sistema de gestión de terceros, facturas y pagos"));
	}
}
