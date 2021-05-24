// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'bootstrap/dist/css/bootstrap';

Rails.start()
ActiveStorage.start()

document.addEventListener("DOMContentLoaded", () => {
  let ele = document.getElementById('method_name')
  ele.addEventListener('change', (ev) => {
    let frm = document.getElementById('form')
    frm.method = ev.currentTarget.value
  })
})
