<cfscript>
    /** ensure that we have Session.username and set a default channel */

    if (!isNull(URL.username))
        Session.username = URL.username;

    if (!isNull(URL.channel))
        Session.channel = URL.channel;

    if (isEmpty(Session.username ?: "")){

        echo("<p>Session.username is not defined. Set it using the URL parameter username, e.g. ?username=Lucy");
        abort;
    }

    if (isEmpty(Session.channel ?: "")){

        echo("<p>Session.channel is not defined. Set it using the URL parameter channel, e.g. ?channel=test");
        abort;
    }
</cfscript>


<cfoutput>
    <script>
        var channel  = "#Session.channel#";
        var endpoint = "/ws/chat/" + channel;
        var protocol = (document.location.protocol == "https:") ? "wss://" : "ws://";

        var wschat   = new WebSocket(protocol + document.location.host + endpoint);

        var log = function(evt){
            console.log(evt.data ? JSON.parse(evt.data) : evt);
        };
        wschat.onopen    = log;
        wschat.onmessage = log;
        wschat.onerror   = log;
        wschat.onclose   = log;

        document.title   = `#Session.username# on ${channel}`;
        document.write(`<p>[wschat] connected to "${channel}" as "#Session.username#"`);
    </script>
</cfoutput>