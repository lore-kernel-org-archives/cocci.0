From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 30 Sep 2014 13:57:37 +0200 (CEST)
Subject: [Cocci] Further ideas from the release "1.0.0-rc22"
In-Reply-To: <542A95D4.9060709@users.sourceforge.net>
References: <alpine.DEB.2.10.1409301011200.2442@hadrien>
 <542A95D4.9060709@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1409301356380.2442@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > --parse-handler: This new option makes it possible to give a file name
> > containing OCaml code to invoke on a parse error.  It allows displaying
> > the parse error in a custom format.
>
> Can other programming languages be eventually also reused here for special error
> reporting?

Not currently.

> I would like to clarify another implementation detail because of more surprising
> error messages:
> ?
> kpathsea: Running mktextfm ptmr8t
> /usr/share/texmf/web2c/mktexnam: Could not map source abbreviation  for ptmr8t.
> /usr/share/texmf/web2c/mktexnam: Need to update ?
> mktextfm: Running mf-nowin -progname=mf \mode:=ljfour; mag:=1; nonstopmode;
> input ptmr8t
> This is METAFONT, Version 2.718281 (TeX Live 2013/TeX Live for SUSE Linux)
>
>
> kpathsea: Running mktexmf ptmr8t
> ! I can't find file `ptmr8t'.
> <*> ...:=ljfour; mag:=1; nonstopmode; input ptmr8t
>
> Please type another input file name
> ! Emergency stop.
> <*> ...:=ljfour; mag:=1; nonstopmode; input ptmr8t
>
> Transcript written on mfput.log.
> grep: ptmr8t.log: Datei oder Verzeichnis nicht gefunden
> mktextfm: `mf-nowin -progname=mf \mode:=ljfour; mag:=1; nonstopmode; input
> ptmr8t' failed to make ptmr8t.tfm.
> kpathsea: Appending font creation commands to missfont.log.
>
> ! Font T1/ptm/m/n/10=ptmr8t at 10.0pt not loadable: Metric (TFM) file not found
> .
> <to be read again>
>                    relax
> l.85 \begin{document}
>
> !  ==> Fatal error occurred, no output PDF file produced!
> Transcript written on manual.log.
> ?
>
> Which software package should provide the needed font files for the
> documentation generation process?

I don't know about the installation of latex on Suse.  Perhaps google for
the error and see what comes up.

julia
