From: josh@joshtriplett.org (Josh Triplett)
Date: Sat, 2 Nov 2013 08:01:55 -0700
Subject: [Cocci] if (...) {} semantic patch
In-Reply-To: <alpine.DEB.2.02.1311021541590.2261@hadrien>
References: <20131102133648.GA4190@leaf>
 <alpine.DEB.2.02.1311021541590.2261@hadrien>
Message-ID: <20131102150155.GU15704@leaf>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Nov 02, 2013 at 03:46:52PM +0100, Julia Lawall wrote:
> I think that there are more side-effecting expressions that you should
> consider, eg E += E2, etc.
> 
> The following lines from the SmPL lexer shows the operators that are
> supported:
> 
>   | "-="           { start_line true; mkassign Ast.Minus lexbuf }
>   | "+="           { start_line true; mkassign Ast.Plus lexbuf }
>   | "*="           { start_line true; mkassign Ast.Mul lexbuf }
>   | "/="           { start_line true; mkassign Ast.Div lexbuf }
>   | "%="           { start_line true; mkassign Ast.Mod lexbuf }
>   | "&="           { start_line true; mkassign Ast.And lexbuf }
>   | "|="           { start_line true; mkassign Ast.Or lexbuf }
>   | "^="           { start_line true; mkassign Ast.Xor lexbuf }
>   | ">?="           { start_line true; mkassign Ast.Max lexbuf }
>   | "<?="           { start_line true; mkassign Ast.Min lexbuf }
>   | "<<="          { start_line true; mkassign Ast.DecLeft lexbuf }
>   | ">>="          { start_line true; mkassign Ast.DecRight lexbuf }

Interesting.  I went by the example in
http://coccinelle.lip6.fr/rules/bugon.html , which doesn't include
those.  I had assumed that the compound assignment operators were
subject to some kind of isomorphism that made matching them unnecessary.

You might consider providing some shortcut for matching code that has
side effects.

> Also, if the output from -D patch is sometimes undesirable, it would be
> useful to mention that in the initial comments about the semantic patch,
> so that the user knows that there is something to look for.  The
> convention seems to be to put such comments after //#

Fair enough.

A couple of examples of the type of suboptimal output I meant in the
commit message:

--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -296,7 +296,8 @@ static void __init u8500_init_machine(vo
 		snowball_pinmaps_init();
 	} else if (of_machine_is_compatible("st-ericsson,hrefv60+"))
 		hrefv60_pinmaps_init();
-	else if (of_machine_is_compatible("st-ericsson,ccu9540")) {}
+	else {of_machine_is_compatible("st-ericsson,ccu9540");
+}
 		/* TODO: Add pinmaps for ccu9540 board. */
 
 	/* automatically probe child nodes of dbx5x0 devices */

Leaving aside the issue that of_machine_is_compatible has no side
effects, the formatting is clearly wrong there.

--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -3232,9 +3232,7 @@ void pm8001_bytes_dmaed(struct pm8001_hb
 		id->dev_type = phy->identify.device_type;
 		id->initiator_bits = SAS_PROTOCOL_ALL;
 		id->target_bits = phy->identify.target_port_protocols;
-	} else if (phy->phy_type & PORT_TYPE_SATA) {
-		/*Nothing*/
-	}
+	} else {}
 	PM8001_MSG_DBG(pm8001_ha, pm8001_printk("phy %d byte dmaded.\n", i));
 
 	sas_phy->frame_rcvd_size = phy->frame_rcvd_size;

This one should have the else dropped entirely.

--- a/arch/mn10300/kernel/signal.c
+++ b/arch/mn10300/kernel/signal.c
@@ -413,8 +413,7 @@ static void do_signal(struct pt_regs *re
 
 	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
 	if (signr > 0) {
-		if (handle_signal(signr, &info, &ka, regs) == 0) {
-		}
+		handle_signal(signr, &info, &ka, regs) == 0;
 
 		return;
 	}

Here, the " == 0" is unnecessary.

- Josh Triplett
