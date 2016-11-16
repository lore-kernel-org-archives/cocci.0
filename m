From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 16 Nov 2016 15:15:45 +0100 (CET)
Subject: [Cocci] SmPL script construction with included files
In-Reply-To: <69c3643e-10b4-007a-f847-d0098f298e16@users.sourceforge.net>
References: <3c65eb92-8be0-be42-bf8e-893f3853df12@users.sourceforge.net>
 <alpine.DEB.2.20.1611152248150.2060@hadrien>
 <32639cf9-b644-0230-02a6-88d66925340e@users.sourceforge.net>
 <alpine.DEB.2.10.1611161152570.3153@hadrien>
 <6810eb15-839c-8aa5-6485-401d43ba1246@users.sourceforge.net>
 <alpine.DEB.2.10.1611161350550.3153@hadrien>
 <69c3643e-10b4-007a-f847-d0098f298e16@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1611161514250.3153@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I am thinking about an other use case a bit more where I have got a few
> SmPL script templates which are working to some degree. If I would like
> to use also the functionality ?Script constraints on meta-variables?
> (instead of a big regular expression) for a function name selection on
> demand there, I am going to recombine existing pieces by a corresponding
> make script as a kind of preprocessing step.

The idea with the script constraints on metavariables feature is that the
script code there should only contain a function call.  The actual
function definition should be elsewhere; probably in an initialize rule.

julia
