From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 10 Oct 2013 08:35:19 +0200 (CEST)
Subject: [Cocci] problem with a (contorted) macro
In-Reply-To: <1381324407.3213.42.camel@zamolxis.metaware.tm.fr>
References: <1381311937.3213.23.camel@zamolxis.metaware.tm.fr>
 <alpine.DEB.2.02.1310091155210.2237@hadrien>
 <1381324407.3213.42.camel@zamolxis.metaware.tm.fr>
Message-ID: <alpine.DEB.2.02.1310100834020.2043@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

In the file parsing_c/unparse_cocci.ml, in the function:

      let prnl x =
	(if unindent_before x then unindent true);
	force_newline() in

Try getting rid of the first line.

It is not a good solution because the code may be less well pretty 
printed, but it may work.

julia
