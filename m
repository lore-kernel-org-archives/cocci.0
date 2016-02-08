From: bp@alien8.de (Borislav Petkov)
Date: Mon, 8 Feb 2016 17:45:45 +0100
Subject: [Cocci] [Xen-devel] [PATCH v2 3/3] paravirt: rename
 paravirt_enabled to paravirt_legacy
In-Reply-To: <56B8C490.1060004@citrix.com>
References: <CALCETrWSiN+te_0aYH0NH9oBzGALLhKqxkupiGwbAm2GdCNyVQ@mail.gmail.com>
 <20160206220437.GA4435@pd.tnic> <56B8B6BF.6030007@oracle.com>
 <20160208155507.GF28980@pd.tnic> <56B8BCDB.9040701@citrix.com>
 <56B8BE58.6070003@oracle.com> <56B8C1BC.9040603@citrix.com>
 <56B8C2C8.8050406@oracle.com> <20160208163526.GI28980@pd.tnic>
 <56B8C490.1060004@citrix.com>
Message-ID: <20160208164545.GJ28980@pd.tnic>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Feb 08, 2016 at 04:38:40PM +0000, Andrew Cooper wrote:
> Does the early loader have extable support?  If so, this is fairly easy
> to fix.  If not, we have a problem.

It doesn't and regardless, you want to have this CPUID querying as
simple as possible. No special handling, no special prefixes as it
should be able to run on other hypervisors too.

If one can't execute a simple CPUID(0x4...) on a xen guest and get the
results back, then for early, we will have to do what we've done until
now and simply emulate the MSR accesses.

Later code can use then xen_cpuid() and all is fine. We should still get
rid of paravirt_enabled() though.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
