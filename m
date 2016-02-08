From: andrew.cooper3@citrix.com (Andrew Cooper)
Date: Mon, 8 Feb 2016 16:38:40 +0000
Subject: [Cocci] [Xen-devel] [PATCH v2 3/3] paravirt: rename
 paravirt_enabled to paravirt_legacy
In-Reply-To: <20160208163526.GI28980@pd.tnic>
References: <CALCETrU3DaqUeo-n2dV_UmeAcTEV2dQRtxyb-atMP6WFDDif3Q@mail.gmail.com>
 <20160206085930.GF25240@wotan.suse.de>
 <CALCETrWSiN+te_0aYH0NH9oBzGALLhKqxkupiGwbAm2GdCNyVQ@mail.gmail.com>
 <20160206220437.GA4435@pd.tnic> <56B8B6BF.6030007@oracle.com>
 <20160208155507.GF28980@pd.tnic> <56B8BCDB.9040701@citrix.com>
 <56B8BE58.6070003@oracle.com> <56B8C1BC.9040603@citrix.com>
 <56B8C2C8.8050406@oracle.com> <20160208163526.GI28980@pd.tnic>
Message-ID: <56B8C490.1060004@citrix.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 08/02/16 16:35, Borislav Petkov wrote:
> On Mon, Feb 08, 2016 at 11:31:04AM -0500, Boris Ostrovsky wrote:
>> I think we are OK for PV because this code will be executed after pvops are
>> set and so we will be calling xen_cpuid().
> Not for the early loader - it is too early for pvops then. So you're
> saying something like that won't work?

Correct.  PV guests are ring-deprivilelged so the cpuid instruction
doesn't trap in general.  (It does on more modern Intel hardware with
cpuid faulting enabled, but that is only IvyBridge and newer).

Does the early loader have extable support?  If so, this is fairly easy
to fix.  If not, we have a problem.

~Andrew
