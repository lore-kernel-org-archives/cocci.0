From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 17 Jul 2013 17:31:15 +0200 (CEST)
Subject: [Cocci] Formatting issues
In-Reply-To: <51E6B532.8010909@monom.org>
References: <51E6B08E.9030600@monom.org>
 <alpine.DEB.2.02.1307171706400.2113@hadrien> <51E6B532.8010909@monom.org>
Message-ID: <alpine.DEB.2.02.1307171728420.2113@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Another formatting issue I found is triggered by a different rule. I figure
> the expression 'E' is written out as one line and the original formatting gets
> lost.

Yes, there is not much I can do about this one.  When you match code into 
a metavariable, all of the whitespace and comments go away.  It doesn't 
know that you still want them in the place where you add the metavariable 
back in.

If you have a probleme with this, as in your example, you can try to 
rewrite the semantic patch so that the metavariable is there but does not 
appear in the - and + code.  For example, for your first case below you 
can write

E
- == TRUE

julia

> @@
> expression E;
> symbol TRUE;
> symbol FALSE;
> @@
>
> (
> - E == TRUE
> + E
> |
> - TRUE == E
> + E
> |
> - E != TRUE
> + !E
> |
> - TRUE != E
> + !E
> |
> - E == FALSE
> + !E
> |
> - FALSE == E
> + !E
> |
> - E != FALSE
> + E
> |
> - FALSE != E
> + E
> )
>
>
> the C code:
>
>
> #define AGENT_INTERFACE ""
>
> int main(int argc, char *argv[])
> {
> 	if (g_dbus_register_interface(connection, path,
> 					AGENT_INTERFACE, agent_methods,
> 					NULL, NULL, &agent_request,
> 					NULL) == FALSE) {
> 		fprintf(stderr, "Error: Failed to register Agent callbacks\n");
>                return 0;
>        }
>
> 	return 0;
> }
>
>
> gives me this here:
>
>
> int main(int argc, char *argv[])
> {
> -       if (g_dbus_register_interface(connection, path,
> -                                       AGENT_INTERFACE, agent_methods,
> -                                       NULL, NULL, &agent_request,
> -                                       NULL) == FALSE) {
> +       if (!g_dbus_register_interface(connection, path, AGENT_INTERFACE, agent_methods, NULL, NULL, &agent_request, NULL)) {
>                fprintf(stderr, "Error: Failed to register Agent callbacks\n");
>                 return 0;
>         }
>
> cheers,
> daniel
>
>
