From: arend.vanspriel@broadcom.com (Arend van Spriel)
Date: Fri, 16 Jun 2017 11:01:02 +0200
Subject: [Cocci] matching variations of function result check
Message-ID: <386ba17e-4cd7-9248-3304-e1809a65fffa@broadcom.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I am trying to write a cocci script as below:

@@
identifier NDEV;
int RES;
@@

  RES = register_netdevice(NDEV);
  if (RES) {
	<...
-	free_netdev(NDEV);
+	foo(NDEV);
+	free_netdev(NDEV);
	...>
  }

However, I want to catch more variations, ie.

	if (RES < 0)
	if (RES != 0)
	if (register_netdevice(NDEV) < 0)

and so on. To boot the function call may either be register_netdevice or 
register_netdev.

Now I can create rules for all variations, but I was wondering if I 
could do things smarter. The grammar documentation [1] always confuses 
me mixing it all with C grammar.

Regards,
Arend
