package utn.frp.comp.terceros.model;

import java.math.BigDecimal;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "terceros")
public class Tercero {

	public enum SituacionIVA {
		MONOTRIBUTO("Monotributo"),
		RESPONSABLE_INSCRIPTO("Responsable Inscripto"),
		CONSUMIDOR_FINAL("Consumidor Final");

		private final String descripcion;

		SituacionIVA(String descripcion) {
			this.descripcion = descripcion;
		}

		public String getDescripcion() {
			return descripcion;
		}
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id_tercero")
	private Long id;

	@NotBlank(message = "El nombre es obligatorio")
	@Column(name = "nombre")
	private String nombre;

	@NotBlank(message = "El CUIT es obligatorio")
	@Column(name = "cuitl")
	private String cuit;

	@Enumerated(EnumType.STRING)
	@Column(name = "sitiva", nullable = false)
	@NotNull(message = "La situación IVA es obligatoria")
	private SituacionIVA sitiva;

	@NotBlank(message = "La dirección es obligatoria")
	@Column(name = "direccion")
	private String direccion;

	@NotBlank(message = "La localidad es obligatoria")
	@Column(name = "localidad")
	private String localidad;

	@NotBlank(message = "La provincia es obligatoria")
	@Column(name = "provincia")
	private String provincia;

	@NotBlank(message = "Los teléfonos son obligatorios")
	@Column(name = "telefonos")
	private String telefonos;

	@NotNull(message = "El saldo de apertura es obligatorio")
	@Column(name = "saldo_apertura")
	private BigDecimal saldoApertura;

	@NotBlank(message = "El tipo de saldo es obligatorio")
	@Column(name = "tipo_saldo")
	private String tipoSaldo;

	@OneToMany(mappedBy = "tercero", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private List<Factura> listaTerceros;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getCuit() {
		return cuit;
	}

	public void setCuit(String cuit) {
		this.cuit = cuit;
	}

	public SituacionIVA getSitiva() {
		return sitiva;
	}

	public void setSitiva(SituacionIVA sitiva) {
		this.sitiva = sitiva;
	}

	public String getDireccion() {
		return direccion;
	}

	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}

	public String getLocalidad() {
		return localidad;
	}

	public void setLocalidad(String localidad) {
		this.localidad = localidad;
	}

	public String getProvincia() {
		return provincia;
	}

	public void setProvincia(String provincia) {
		this.provincia = provincia;
	}

	public String getTelefonos() {
		return telefonos;
	}

	public void setTelefonos(String telefonos) {
		this.telefonos = telefonos;
	}

	public BigDecimal getSaldoApertura() {
		return saldoApertura;
	}

	public void setSaldoApertura(BigDecimal saldoApertura) {
		this.saldoApertura = saldoApertura;
	}

	public String getTipoSaldo() {
		return tipoSaldo;
	}

	public void setTipoSaldo(String tipoSaldo) {
		this.tipoSaldo = tipoSaldo;
	}
}
