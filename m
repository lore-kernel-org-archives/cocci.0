From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 4 Jan 2018 15:09:16 +0100 (CET)
Subject: [Cocci] Sources with high badcount
In-Reply-To: <6118e43b-bdba-0b6f-13a4-8caba08ec3e0@orange.fr>
References: <6118e43b-bdba-0b6f-13a4-8caba08ec3e0@orange.fr>
Message-ID: <alpine.DEB.2.20.1801041507290.3077@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 4 Jan 2018, Francois-Xavier Le Bail wrote:

> Hi,
>
> I got high badcounts with some sources.

Actually, in this case there are just some parse errrors in the code.

ND_PRINT((ndo, " from %s", etheraddr_string(... (line 302)
This is missing one )

ND_PRINT((ndo, ", hops %d", EXTRACT_U_1(... (line 322)
This has one ) too many.

julia


>
> One of them is:
> https://raw.githubusercontent.com/the-tcpdump-group/tcpdump/master/print-bootp.c
>
> Options are: --debug --verbose-parsing --no-includes
> Partial log is:
> =======================================================================
> init_defs_builtins: /usr/local/bin/../lib/coccinelle/standard.h
> -----------------------------------------------------------------------
> processing semantic patch file: ../u_char_p.cocci
> with isos from: /usr/local/bin/../lib/coccinelle/standard.iso
> -----------------------------------------------------------------------
> @@
> u_char *p;
> @@
> * p
>
> HANDLING: print-bootp.c
> -----------------------------------------------------------------------
> let's go
> -----------------------------------------------------------------------
> -----------------------------------------------------------------------
> ERROR-RECOV: found sync '}' at line 402
> parsing pass2: try again
> (ONCE) CPP-DEFINE: inside function, I treat it as comment
> (ONCE) CPP-UNDEF: inside function, I treat it as comment
> ERROR-RECOV: found sync '}' at line 402
> parsing pass3: try again
> PB: not found closing brace in fuzzy parsing
> ERROR-RECOV: found sync '}' at line 402
> parsing pass4: try again
> PB: not found closing brace in fuzzy parsing
> ERROR-RECOV: found sync '}' at line 402
> parse error
>  = File "print-bootp.c", line 1116, column 0, charpos = 31388
>   around = '',
>   whole content =
> badcount: 125
> bad: };
> bad:
> bad: /*
> bad:  * Print bootp requests
> bad:  */
> bad: void
> bad: bootp_print(netdissect_options *ndo,
> bad:        const u_char *cp, u_int length)
> bad: {
> bad:    const struct bootp *bp;
> bad:    static const u_char vm_cmu[4] = VM_CMU;
> bad:    static const u_char vm_rfc1048[4] = VM_RFC1048;
> bad:    uint8_t bp_op, bp_htype, bp_hlen;
> bad:
> bad:    bp = (const struct bootp *)cp;
> bad:    ND_TCHECK(bp->bp_op);
> bad:    bp_op = EXTRACT_U_1(bp->bp_op);
> bad:    ND_PRINT((ndo, "BOOTP/DHCP, %s",
> bad:              tok2str(bootp_op_values, "unknown (0x%02x)", bp_op)));
> bad:
> [...]
> =======================================================================
>
> The line 402 is the closing '}' of the 'bootp_print' function.
>
> Any clue ?
>
> --
> Francois-Xavier
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
