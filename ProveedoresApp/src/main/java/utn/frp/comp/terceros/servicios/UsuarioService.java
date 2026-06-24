package utn.frp.comp.terceros.servicios;

import java.util.Optional;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import utn.frp.comp.terceros.model.Usuario;
import utn.frp.comp.terceros.repositorios.UsuarioRepository;

@Service
public class UsuarioService {

	private final UsuarioRepository usuarioRepository;
	private final PasswordEncoder passwordEncoder;

	public UsuarioService(UsuarioRepository usuarioRepository, PasswordEncoder passwordEncoder) {
		this.usuarioRepository = usuarioRepository;
		this.passwordEncoder = passwordEncoder;
	}

	public Optional<Usuario> login(String username, String password) {
		Optional<Usuario> usuarioOpt = usuarioRepository.findByUsername(username);
		if (usuarioOpt.isPresent() && usuarioOpt.get().isActivo()
				&& passwordEncoder.matches(password, usuarioOpt.get().getPassword())) {
			return usuarioOpt;
		}
		return Optional.empty();
	}

	public Usuario registrarUsuario(String username, String password) {
		if (usuarioRepository.findByUsername(username).isPresent()) {
			throw new IllegalArgumentException("El usuario ya existe");
		}
		Usuario usuario = new Usuario();
		usuario.setUsername(username);
		usuario.setPassword(passwordEncoder.encode(password));
		usuario.setActivo(true);
		return usuarioRepository.save(usuario);
	}
}
