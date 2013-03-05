From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 05 Mar 2013 18:08:30 +0100
Subject: [Cocci] Addition of source code documentation generation to the
 build system?
In-Reply-To: <CANrVCd1rFXSmrtCCWq6K8E81wSq6n1MdztQuN-9vY16dBtsd_A@mail.gmail.com>
References: <5133B0BF.8000608@users.sourceforge.net>
 <alpine.DEB.2.02.1303041106480.1984@hadrien>
 <5134918E.7090304@users.sourceforge.net>
 <alpine.DEB.2.02.1303041338350.1984@hadrien>
 <5135B8DB.30307@users.sourceforge.net>
 <alpine.DEB.2.02.1303051028450.1954@hadrien>
 <5135C125.6070707@users.sourceforge.net>
 <alpine.DEB.2.02.1303051104310.1954@hadrien>
 <5135C74D.8000602@users.sourceforge.net>
 <alpine.DEB.2.02.1303051126520.1954@hadrien>
 <5135CC1F.6090608@users.sourceforge.net>
 <alpine.DEB.2.02.1303051145190.1954@hadrien>
 <5135F21A.2080809@users.sourceforge.net>
 <CANrVCd1rFXSmrtCCWq6K8E81wSq6n1MdztQuN-9vY16dBtsd_A@mail.gmail.com>
Message-ID: <5136268E.50602@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I'm sorry but configure generates only constants containing paths,
> which specify - depending on the system configuration and preferences
> - where binaries/sources of various packages are located.

The Autotools infrastructure ensures that these macros will be applied by
Makefiles at the appropriate places.


> It does not generate invocations of the ocaml compiler nor of ocamldoc.

I agree because these tools do not belong to software which are supported by the
autoconf build system by default. I guess that this can be added by adjustments
of ".in" (or ".am" eventually) files easily.
http://www.gnu.org/software/automake/manual/html_node/automake-Invocation.html


> Like with all other tools, in order to use ocamldoc you'll need to
> make sure that it gets the appropriate inputs, such as compiled
> interface files.

I find it a technical challenge at the moment to collect the needed parameters
in a consistent way.


> However, it will involve manual labour.

I hope to avoid that.


> When I tried it once, ocamldoc failed to parse some sources, so you
> cannot expect it to handle evertything.

Thanks for your background information.


> As I wrote before, ocamlbuild has some hidden magic for documentation
> generation. So if you can get coccinelle to build with it, you might
> get documentation out as well without having to do a lot of work. Note
> that we do not officially support ocamlbuild so if it does not work
> for you, you can forget this last paragraph.

I hope that this aspect will change in the future.

Regards,
Markus
