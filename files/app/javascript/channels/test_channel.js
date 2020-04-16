import consumer from "./consumer"

consumer.subscriptions.create("TestChannel", {
  connected() {
    this.replaceElement('test-channel-status', 'connected')
  },

  disconnected() {
    this.replaceElement('test-channel-status', 'connecting...')
  },

  received(data) {
    // console.log(data)
    this.replaceElement('test-channel-device-count', data.deviceCount)
  },

  replaceElement(id, content) {
    const div = document.getElementById(id)
    div.innerHTML = content
  }
});
