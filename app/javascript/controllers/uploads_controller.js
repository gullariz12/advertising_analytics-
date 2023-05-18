import { Controller } from "@hotwired/stimulus"
import { post } from '@rails/request.js';

export default class extends Controller {
  static values = { url: String }

  attach(event) {
    const fileInput = event.target;
    const file = fileInput.files[0];

    const formData = new FormData();
    formData.append('file', file);

    post(this.urlValue, {
      body: formData,
      responseKind: "turbo-stream",
      traditional: true
    });
  }
}
