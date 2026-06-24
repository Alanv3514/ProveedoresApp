package utn.frp.comp.terceros.model;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "pagos_detalle")
public class PagoDetalle {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id_pagosdetalle")
	private Long id;

	@Column(name = "instrumentnumber")
	private String numeroInstrumento;

	@Column(name = "instrumentdate")
	private LocalDate fechaInstrumento;

	@Column(name = "banco")
	private String banco;

	@Column(name = "pagorealizado")
	private Boolean pagoRealizado;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "id_pagos", nullable = false)
	@JsonIgnoreProperties("listaDetalles")
	private Pago pago;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getNumeroInstrumento() {
		return numeroInstrumento;
	}

	public void setNumeroInstrumento(String numeroInstrumento) {
		this.numeroInstrumento = numeroInstrumento;
	}

	public LocalDate getFechaInstrumento() {
		return fechaInstrumento;
	}

	public void setFechaInstrumento(LocalDate fechaInstrumento) {
		this.fechaInstrumento = fechaInstrumento;
	}

	public String getBanco() {
		return banco;
	}

	public void setBanco(String banco) {
		this.banco = banco;
	}

	public Boolean getPagoRealizado() {
		return pagoRealizado;
	}

	public void setPagoRealizado(Boolean pagoRealizado) {
		this.pagoRealizado = pagoRealizado;
	}

	public Pago getPago() {
		return pago;
	}

	public void setPago(Pago pago) {
		this.pago = pago;
	}
}
