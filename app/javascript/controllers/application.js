
// This enables correct usage in other modules that import from 'controllers/application'
import * as Turbo from "@hotwired/turbo-rails"  
import { Application } from "@hotwired/stimulus"
import "controllers"

const application = Application.start()
application.debug = false
window.Stimulus = application
window.Turbo = Turbo   

export { application }
