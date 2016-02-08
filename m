From: andrew.cooper3@citrix.com (Andrew Cooper)
Date: Mon, 8 Feb 2016 16:53:00 +0000
Subject: [Cocci] [Xen-devel] [PATCH v2 3/3] paravirt: rename
 paravirt_enabled to paravirt_legacy
In-Reply-To: <20160208164545.GJ28980@pd.tnic>
References: <CALCETrWSiN+te_0aYH0NH9oBzGALLhKqxkupiGwbAm2GdCNyVQ@mail.gmail.com>
 <20160206220437.GA4435@pd.tnic> <56B8B6BF.6030007@oracle.com>
 <20160208155507.GF28980@pd.tnic> <56B8BCDB.9040701@citrix.com>
 <56B8BE58.6070003@oracle.com> <56B8C1BC.9040603@citrix.com>
 <56B8C2C8.8050406@oracle.com> <20160208163526.GI28980@pd.tnic>
 <56B8C490.1060004@citrix.com> <20160208164545.GJ28980@pd.tnic>
Message-ID: <56B8C7EC.3090403@citrix.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 08/02/16 16:45, Borislav Petkov wrote:
> On Mon, Feb 08, 2016 at 04:38:40PM +0000, Andrew Cooper wrote:
>> Does the early loader have extable support?  If so, this is fairly easy
>> to fix.  If not, we have a problem.
> It doesn't and regardless, you want to have this CPUID querying as
> simple as possible. No special handling, no special prefixes as it
> should be able to run on other hypervisors too.
>
> If one can't execute a simple CPUID(0x4...) on a xen guest and get the
> results back, then for early, we will have to do what we've done until
> now and simply emulate the MSR accesses.
>
> Later code can use then xen_cpuid() and all is fine. We should still get
> rid of paravirt_enabled() though.
>

The force emulation prefix starts with a ud2a instruction, so extable is
to prevent it breaking on non-Xen systems.  However, if extable isn't
available, this point is moot.

As an alternative check which should be doable this early on, peeking in
the head of hypercall_page should work.  If Linux was booted as a PV
guest, the hypercall_page will have been constructed by the domain
builder, and won't have 0x90's in it.

~Andrew
