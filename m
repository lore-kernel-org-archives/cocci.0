From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 23 May 2016 13:53:44 +0200 (CEST)
Subject: [Cocci] Deletion of indication for "optional" syntax elements?
In-Reply-To: <f7deb8c8-4b1d-b589-7d0c-53cc2cfe91c7@users.sourceforge.net>
References: <20160511031419.GY3766@xsjsorenbubuntu>
 <alpine.DEB.2.10.1605110738430.5606@hadrien>
 <20160511055515.GA3766@xsjsorenbubuntu>
 <alpine.DEB.2.10.1605110758230.5606@hadrien>
 <20160511060438.GB3766@xsjsorenbubuntu>
 <alpine.DEB.2.10.1605111148220.5036@hadrien>
 <20160511184830.GG3766@xsjsorenbubuntu>
 <66c62c8e-43cd-dbab-7a0a-8d884362a141@users.sourceforge.net>
 <20160512055423.GH3766@xsjsorenbubuntu>
 <alpine.DEB.2.10.1605120905380.3316@hadrien>
 <20160512161637.GN3766@xsjsorenbubuntu>
 <alpine.DEB.2.10.1605121818060.3062@hadrien>
 <f7deb8c8-4b1d-b589-7d0c-53cc2cfe91c7@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1605231352590.2892@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 23 May 2016, SF Markus Elfring wrote:

>
> Looks to me then that the grammar documentation should not indicate
> the fn_ctype as optional for function prototypes
> (http://coccinelle.lip6.fr/docs/main_grammar006.html)?
>
> Indeed.  I'll fix that.
>
>
> Would you like to delete the specification "\opt" at a few places?
> https://github.com/coccinelle/coccinelle/blob/df648d123ac4dad16a855f0c5f3adf42ce602b29/docs/manual/cocci_syntax.tex#L1173

At what place do you have in mind?  The return type of a functin
definition really is optional.  Other than that, I don't kow what is being
referred to, and don't have time to check every instance.

julia
