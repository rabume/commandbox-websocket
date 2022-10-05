component {

    this.name = "websocket_chat";

    function onApplicationStart(){

        WebsocketRegister("/ws/chat/{channel}", new ChatListener());
    }
}