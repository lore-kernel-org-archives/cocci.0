From: bp@alien8.de (Borislav Petkov)
Date: Mon, 8 Feb 2016 17:52:27 +0100
Subject: [Cocci] [Xen-devel] [PATCH v2 3/3] paravirt: rename
 paravirt_enabled to paravirt_legacy
In-Reply-To: <56B8C52C.1070301@oracle.com>
References: <CALCETrWSiN+te_0aYH0NH9oBzGALLhKqxkupiGwbAm2GdCNyVQ@mail.gmail.com>
 <20160206220437.GA4435@pd.tnic> <56B8B6BF.6030007@oracle.com>
 <20160208155507.GF28980@pd.tnic> <56B8BCDB.9040701@citrix.com>
 <56B8BE58.6070003@oracle.com> <56B8C1BC.9040603@citrix.com>
 <56B8C2C8.8050406@oracle.com> <20160208163526.GI28980@pd.tnic>
 <56B8C52C.1070301@oracle.com>
Message-ID: <20160208165227.GL28980@pd.tnic>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Feb 08, 2016 at 11:41:16AM -0500, Boris Ostrovsky wrote:
> Keep in mind that Xen PV doesn't go through startup_32|64(). It starts at
> xen_start_kernel (save for a small stub before that), which sets pvops.  It
> "joins" regular/baremetal code in
> i386_start_kernel/x86_64_start_reservation().

Ah, so one more reason not to do the CPUID thing for the early loader.

So it's up to you how to replace that paravirt_enabled() thing - CPUID
or test static_cpu_has(X86_FEATURE_XENPV)...

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
