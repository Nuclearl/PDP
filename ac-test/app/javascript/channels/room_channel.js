import consumer from "./consumer"

document.addEventListener('turbolinks:load', ()=> {
  const element = document.getElementById('room-id')
  const room_id = element.getAttribute('data-room-id')

  consumer.subscriptions.create({channel: "RoomChannel", room_id: room_id}, {
    connected() {
      console.log(room_id)
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      let html = ''
      data.forEach(msg => {
        html += `<p>${msg['content']}</p>`
      })
      element.innerHTML = html
    },
  });
})

