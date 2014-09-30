From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 30 Sep 2014 13:36:52 +0200
Subject: [Cocci] Further ideas from the release "1.0.0-rc22"
In-Reply-To: <alpine.DEB.2.10.1409301011200.2442@hadrien>
References: <alpine.DEB.2.10.1409301011200.2442@hadrien>
Message-ID: <542A95D4.9060709@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I thank you very much for your software improvements.


> If you need type information, but don't anticipate that any matching
> or transformation is needed that crosses the boundary between the header files
> and the .c file, then using this option can give a big performance improvement.

Would anybody like to publish any run time statistics for comparison of effects
from the added parameter "include-headers-for-types"?


> --parse-handler: This new option makes it possible to give a file name
> containing OCaml code to invoke on a parse error.  It allows displaying
> the parse error in a custom format.

Can other programming languages be eventually also reused here for special error
reporting?


> Some improvements in the handling of PCRE regular expressions to avoid
> strange crashes.

I like this software correction. I have tried it out with my big regular
expression in a SmPL constraint for a patch approach on current Linux source
files a moment ago.


> The tools directory now contains an interactive tool named sgen, developed
> by Chi Pham, for generating semantic patches in the form required by the
> Linux kernel.

Should I rewrite the approach "Deletion of unnecessary checks before specific
function calls" which I posted to Linux mailing lists on 2014-03-05 according to
this interface?



I would like to clarify another implementation detail because of more surprising
error messages:
?
kpathsea: Running mktextfm ptmr8t
/usr/share/texmf/web2c/mktexnam: Could not map source abbreviation  for ptmr8t.
/usr/share/texmf/web2c/mktexnam: Need to update ?
mktextfm: Running mf-nowin -progname=mf \mode:=ljfour; mag:=1; nonstopmode;
input ptmr8t
This is METAFONT, Version 2.718281 (TeX Live 2013/TeX Live for SUSE Linux)


kpathsea: Running mktexmf ptmr8t
! I can't find file `ptmr8t'.
<*> ...:=ljfour; mag:=1; nonstopmode; input ptmr8t

Please type another input file name
! Emergency stop.
<*> ...:=ljfour; mag:=1; nonstopmode; input ptmr8t

Transcript written on mfput.log.
grep: ptmr8t.log: Datei oder Verzeichnis nicht gefunden
mktextfm: `mf-nowin -progname=mf \mode:=ljfour; mag:=1; nonstopmode; input
ptmr8t' failed to make ptmr8t.tfm.
kpathsea: Appending font creation commands to missfont.log.

! Font T1/ptm/m/n/10=ptmr8t at 10.0pt not loadable: Metric (TFM) file not found
.
<to be read again>
                   relax
l.85 \begin{document}

!  ==> Fatal error occurred, no output PDF file produced!
Transcript written on manual.log.
?

Which software package should provide the needed font files for the
documentation generation process?

Regards,
Markus
