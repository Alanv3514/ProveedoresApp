package utn.frp.comp.terceros.model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonManagedReference;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "pagos")
public class Pago {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id_pagos")
	private Long id;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "id_tercero", nullable = false)
	@NotNull(message = "El tercero es obligatorio")
	private Tercero tercero;

	@NotNull(message = "La fecha de pago es obligatoria")
	@Column(name = "fecha_pago")
	private LocalDate fechaPago;

	@NotNull(message = "El monto de pago es obligatorio")
	@Column(name = "monto_pago")
	private BigDecimal montoPago;

	@NotBlank(message = "El modo de pago es obligatorio")
	@Column(name = "modo_pago")
	private String modoPago;

	@OneToMany(mappedBy = "pago", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
	@JsonManagedReference
	private List<PagoDetalle> listaDetalles;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Tercero getTercero() {
		return tercero;
	}

	public void setTercero(Tercero tercero) {
		this.tercero = tercero;
	}

	public LocalDate getFechaPago() {
		return fechaPago;
	}

	public void setFechaPago(LocalDate fechaPago) {
		this.fechaPago = fechaPago;
	}

	public BigDecimal getMontoPago() {
		return montoPago;
	}

	public void setMontoPago(BigDecimal montoPago) {
		this.montoPago = montoPago;
	}

	public String getModoPago() {
		return modoPago;
	}

	public void setModoPago(String modoPago) {
		this.modoPago = modoPago;
	}

	public List<PagoDetalle> getListaDetalles() {
		return listaDetalles;
	}

	public void setListaDetalles(List<PagoDetalle> listaDetalles) {
		this.listaDetalles = listaDetalles;
	}
}
