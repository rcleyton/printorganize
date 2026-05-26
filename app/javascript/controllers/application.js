import { Application } from "@hotwired/stimulus"
import Notification from '@stimulus-components/notification'
import PasswordVisibility from '@stimulus-components/password-visibility'

const application = Application.start()

application.register('notification', Notification)
application.register('password-visibility', PasswordVisibility)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
