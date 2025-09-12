import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static values = { userId: Number }; // Para capturar el user-id del botón "Editar"

    connect() {
        console.log("User form controller connected");
    }

    // Action para el botón "Editar"
    edit(event) {
        const userId = this.userIdValue;
        console.log(`Editing user with ID: ${userId}`);

        // Realiza una solicitud GET a la acción users#edit con el formato turbo_stream
        fetch(`/users/${userId}/edit`, {
            headers: {
                Accept: "text/vnd.turbo-stream.html", // Solicita una respuesta Turbo Stream
            },
        })
            .then((response) => response.text())
            .then((html) => {
                // Turbo se encargará de esto automáticamente si la respuesta es un Turbo Stream
                // Pero si no, podrías insertar el HTML manualmente aquí
                // document.getElementById('user_form_container').innerHTML = html;
                console.log("Form reloaded for editing via Turbo Stream");
            })
            .catch((error) => console.error("Error fetching edit form:", error));
    }

    // Action para el botón "Cancelar"
    resetForm(event) {
        console.log("Resetting form to create new user");
        // Realiza una solicitud GET a la acción users#new con el formato turbo_stream
        fetch(`/users/new`, { // Asumiendo que /users/new mapea a tu acción new
            headers: {
                Accept: "text/vnd.turbo-stream.html",
            },
        })
            .then((response) => response.text())
            .then((html) => {
                console.log("Form reset to new user via Turbo Stream");
            })
            .catch((error) => console.error("Error resetting form:", error));
    }
}