package utn.frp.comp.terceros.ui;

import com.vaadin.flow.component.Component;
import com.vaadin.flow.component.UI;
import com.vaadin.flow.component.Unit;
import com.vaadin.flow.component.applayout.AppLayout;
import com.vaadin.flow.component.avatar.Avatar;
import com.vaadin.flow.component.avatar.AvatarVariant;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.button.ButtonVariant;
import com.vaadin.flow.component.html.Section;
import com.vaadin.flow.component.html.Span;
import com.vaadin.flow.component.icon.VaadinIcon;
import com.vaadin.flow.component.orderedlayout.FlexComponent;
import com.vaadin.flow.component.orderedlayout.HorizontalLayout;
import com.vaadin.flow.component.orderedlayout.Scroller;
import com.vaadin.flow.component.orderedlayout.ScrollerVariant;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.component.sidenav.SideNav;
import com.vaadin.flow.component.sidenav.SideNavItem;
import com.vaadin.flow.theme.lumo.LumoUtility;

import utn.frp.comp.terceros.seguridad.SeguridadUtils;

public class MainLayout extends AppLayout {

	public MainLayout() {
		setPrimarySection(Section.DRAWER);
		addToDrawer(crearEncabezadoApp(), crearMenuLateral(), crearPieApp());
		addToNavbar(crearBarraNavegacion());
	}

	private Component crearEncabezadoApp() {
		var appLogo = new Avatar("Terceros");
		appLogo.addClassName("app-logo");
		appLogo.addThemeVariants(AvatarVariant.AURA_FILLED, AvatarVariant.XSMALL);

		var appName = new Span("Terceros");
		appName.addClassName("app-name");

		var header = new HorizontalLayout(appLogo, appName);
		header.setAlignItems(FlexComponent.Alignment.CENTER);
		header.setPadding(true);
		return header;
	}

	private Component crearMenuLateral() {
		var scroller = new Scroller(crearSideNav());
		scroller.addThemeVariants(ScrollerVariant.OVERFLOW_INDICATORS);
		return scroller;
	}

	private Component crearPieApp() {
		var footer = new VerticalLayout(new Span("UTN FRP - Programación III"));
		footer.setAlignItems(FlexComponent.Alignment.CENTER);
		footer.addClassName("app-footer");
		return footer;
	}

	private SideNav crearSideNav() {
		var nav = new SideNav();
		nav.setMinWidth(200, Unit.PIXELS);

		nav.addItem(new SideNavItem("Inicio", "/", VaadinIcon.HOME.create()));
		nav.addItem(new SideNavItem("Facultades", "facultad", VaadinIcon.BUILDING.create()));
		nav.addItem(new SideNavItem("Terceros", "tercero", VaadinIcon.USERS.create()));
		nav.addItem(new SideNavItem("Facturas", "factura", VaadinIcon.FILE_TEXT.create()));
		nav.addItem(new SideNavItem("Pagos", "pago", VaadinIcon.MONEY.create()));

		return nav;
	}

	private Component crearBarraNavegacion() {
		var usuario = SeguridadUtils.getUsuarioActual();
		String nombreUsuario = usuario != null ? usuario.getUsername() : "Invitado";

		var userLabel = new Span("Usuario: " + nombreUsuario);

		var logoutButton = new Button("Cerrar Sesión", VaadinIcon.SIGN_OUT.create());
		logoutButton.addThemeVariants(ButtonVariant.LUMO_TERTIARY);
		logoutButton.addClickListener(e -> {
			SeguridadUtils.cerrarSesion();
			UI.getCurrent().getPage().setLocation("/login");
		});

		var layout = new HorizontalLayout(userLabel, logoutButton);
		layout.setAlignItems(FlexComponent.Alignment.CENTER);
		layout.setPadding(true);
		layout.setSpacing(true);
		layout.setWidthFull();
		layout.setJustifyContentMode(FlexComponent.JustifyContentMode.END);

		return layout;
	}
}
