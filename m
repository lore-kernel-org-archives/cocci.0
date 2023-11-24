Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67755C61DF4
	for <cocci@archiver.kernel.org>; Fri, 24 Nov 2023 09:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=UUCbUCyZmyeEe3JdVErp4x5Rr+MVaeUkmyM+CWhy7O8=;
  b=o+325+0PVBvbagcn+2H7JcXH2ejDY1dArukY2LbWvovAwwXFUgLtskyg
   BwE51xe5gEhj4xcL2YyELz7u5RQa8gJuNpYNrqUBPH+LuaT7Ltz2b9nRt
   jANBWExeKy0a2Gc9kKJlWVxBt1PgRbVCq4hnieshFCcQ+JKhc3WZUwfF9
   E=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,223,1695679200"; 
   d="scan'208";a="138287017"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Nov 2023 10:35:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5F5FCE0CCF; Fri, 24 Nov 2023 10:35:18 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 33662E004E
	for <cocci@sympa.inria.fr>; Fri, 24 Nov 2023 10:35:15 +0100 (CET)
IronPort-SDR: 65606e53_Qe5JRpPj3j7P8d8EKq4QxwrpDZcjc9WOfu+WGj10vhUb1pO
 GkzwjGdDABnaqDKStHZenYty4BUjbXvlMSbJjaA==
X-IPAS-Result: =?us-ascii?q?A0H2AgDibGBl/wsR49RaHgEBCxIMQIFEC4I5B3NWMAQLS?=
 =?us-ascii?q?IRTkTIwhDuOfohvgVaBQD4PAQMBDTQNAQIEAQEDAwGEfwKHKQIeBwEEMAkOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAoEGE4VoDYJcARCBDIEeA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECR0IBB?=
 =?us-ascii?q?AEjHQEBEScECwsaAiYCAlcGAQkLAQGCfAGCKQEDDiMHDQawEYEygQGCCQEBB?=
 =?us-ascii?q?q9VHywiVoFfAwaBGi6IDQGFWYQ1Jw+BVUSBPAuCRzE+gmEBA4Feg1uCaIkkB?=
 =?us-ascii?q?4FICYEDg1KEdYoDXSIFQnAbAwcDfw8rBwQwGwcGCRQYFSMGUQQoIQkTEj4Eg?=
 =?us-ascii?q?WCBUQqBAj8PDhGCQCs2NhlIglsVDDRKdhAqBBQXgREEahsTHjcREhcNAwh0H?=
 =?us-ascii?q?QIRIzwDBQMEMwoSDQshBVYDRQZJCwMCGgUDAwSBMwUNHgIQGgYMJwMDEk0CE?=
 =?us-ascii?q?BQDOwMDBgMLMQMHKVVEDE8Dbh82CTwLBAwfAhseDSclAjJCAxEFEgIWAyQWB?=
 =?us-ascii?q?DgRCQsrAy8GOAITDAYGCR4EDgMZKx1AAgELbT01CQsbBj4CJ59fhSCCH8UHN?=
 =?us-ascii?q?AeCMYFfgWAMihaVDQYTL5ciDgaST4gZkCcgjUeabYFjPYFZMxokgzZPAxkPj?=
 =?us-ascii?q?iCEK4ELjjxANQIJMAIHAQoBAQMJhUYBAYNagUABAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 Ik=
IronPort-HdrOrdr: A9a23:iJFkZKzexXqGzdbmbul6KrPw8r1zdoMgy1knxilNoG9uA6+lfq
 eV7Y0mPH7P+VAssRQb8uxoV5PufZqxz+8Q3WBVB8bEYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 JdmsNFaOEYY2IK7/rS3Cn9Nco8y9+a962Sif7Z1GoFd3ARV0gt1WZE4h3wKDwPeOCqP+tDKH
 IWi/Asmwad
X-Talos-CUID: =?us-ascii?q?9a23=3AiEm1omhfcDkJSCJZz0NUMyKN7jJuVCb04GXiJh+?=
 =?us-ascii?q?BMmNjboeWTQea6rk9jJ87?=
X-Talos-MUID: 9a23:iAJ08AVr9BXoarPq/CPwiS8/KP9t2oCjBHgPn8wKlOymGyMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,223,1695679200"; 
   d="scan'208";a="138287003"
X-MGA-submission: =?us-ascii?q?MDExOhg6eipHBAzo4ZRpGM1+Ric9Z8Ts7yxwsg?=
 =?us-ascii?q?jePwddj4cpZ0kXzmJnYumojzjtBmlkDBRUAAIQvM87RIrMY8Y6HF+lNj?=
 =?us-ascii?q?p2LEZYO7AwIE6WmtpkFonlPm/uThZK4KWTQD+vL7EFivrQliZRlDwmCr?=
 =?us-ascii?q?uTYt7gSzXARx/z5V/xXxHD4Q=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 10:35:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700818506; x=1701423306; i=markus.elfring@web.de;
	bh=f9vNw9e6TWApgGZcSJTkPFxRUIsD8ZmziHYzYi6nN98=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=UUnACfA+C6paCwYEBz3Zf8pTC9fgQaSXBnaEODNqfQtvY/ZYCxeieSDYiRPFGnFr
	 vRkgI9J2uGdKHE54H8ICnleYvOog45LrFUkGn30QFbnx9aRuGKm8KH21d3GX7KmOp
	 2+C1yB+4KPSUgfRdRqkSbL8fFr2E2Ic3t9sFbuO40d+XpPjPlCIaPxz2HOpi3nDja
	 p78XM/dG+1inYPnF6N2zYGTDLxNh5ybN6eO/1bChbehQuw2MRjDdfv2eCoxAn+M5x
	 LT2fqKCzlkTwxwHQA2FOlfMNB/WsmDHSPn7pCcv1xC6qVB4ARLFCbHgO2KjWabOY8
	 x/wHULGWwt/+oI65gw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M8kAN-1rB9YW42D3-004hIf; Fri, 24
 Nov 2023 10:35:06 +0100
Message-ID: <087e1c6a-31d2-4205-8afc-5925cc01b20e@web.de>
Date: Fri, 24 Nov 2023 10:35:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <7b59cdf8-5850-49b0-8f91-16d67bf39595@web.de>
 <alpine.DEB.2.22.394.2311240807170.3349@hadrien>
 <05cc07d3-385d-48ea-9e4d-be32c3e863fa@web.de>
 <14be81ed-ab8e-cd1-205e-db30745442d3@inria.fr>
 <d36b547b-a4d2-4e0d-a028-fb9237f99f2e@web.de>
 <d22bd929-b0cb-1b1d-9c8d-3e2e9e1e024@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d22bd929-b0cb-1b1d-9c8d-3e2e9e1e024@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DnNDdBoNkwhWJSzpe0+XAQgI8FIu5AGP2ElZWxf2CFcHjy6EZ8f
 yd43oHet0cQKXEjRzvYAqyJLzq+XttMIsG90urJ9l00To1SM5yDqcsQTU68gRMlG3bcuemY
 TX93BuBT/NQqK6AqlQVC75wgQ5CxQQhCpN0Z+U6u9njb3yIE+tnySYWbXhyc8cp7F3rfFc7
 tFs0wqqrFmKIat3N7RHAw==
UI-OutboundReport: notjunk:1;M01:P0:xakLJqNCJbM=;jTjjdP2Zx44ZZGmzGIL430XttK4
 tyuVDR1DgCeJ/4/SrQ3Vyd2WCJVpGjkkpj1jqTQFcgDEVAwIGfC6ANUU7t4Q0/O4zZ9ENvpIU
 D4h2RNuzjkLI2Z1hINsU4SJ4m33xTQlyrhqSPKaS1El2C4XKaObFddRE+DWUoUfigvUaPDLEK
 sWGtyuoq86WsdyUa+AvMa/WkXROA19qykhTMePENybzu4UyFWn1OhoVd+ZmaQxM7Kv5oClwPy
 BFvZD7txjG3WJd6Sa/Qj4QdqdMFQweqORQekak/5L8nG3HevhMEmubyZWEbc61ml2M7gxzin2
 KE4w+2NebwICn2KK5AV2WWVTZIofYB7JezvXQeDiCs995zzbYwwBmBZQ3qG3BnzocTaOHLNUP
 x2r0vkRxpFnAA8yfaDaeTzAv59FkSZpkdyaaGuVfyrvOB5d+dS+MtFtga1lnMhVOGUvrQu62w
 fgv4yi0oo917ACKzN7bGNEXK2wH2/ziNfzIpPyQ/DyXqGnokYw7srkqfE1KzihzKRgSsfQSwb
 tr+dR5pZNyKivcdrMk8FhuvMTjXThMnDJFedbqc4kZcn7HH1qFYeivaGP4hXRg0aO8a/DVDvr
 obPlXr2pYZEDQLF3Wi2TORMjisByASGtRdZnCpvP6kKiumsgLyP9d7bqTW7cJveEvpUMtbEjb
 d3v/J13eMo79QELcYBxXvNj7a9LukgR/8keuxYNBRt+NI+MflArQ165HdZ13tOK6PJXCgOPZh
 +LEzUvo7EB3t5k19VFXLEMVl+r7J4GuD3COF9WBtvXnEh+pui8xlmlBO0D03qYRsxe2VDj4KH
 zUzZwpqh+I40k5zbgVSXITQ2/NfyiOewGoFmpVbxeZg3xDiaPLq0WjlIb2+PbNGr7m7Y5ox8F
 IsZPjYAF+5Wx1pCZULbuC60c9qENJe/9ZsP6xXFHLYdPDd2t05NijkNYRvb3z9V7yGstNc5Rp
 VqSInQ==
Subject: Re: [cocci] Rechecking Python mapping for position variables
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1331
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/087e1c6a-31d2-4205-8afc-5925cc01b20e%40web.de>

>> * Can it actually happen that more position items are passed to a scrip=
t rule
>>   by a local variable?
>
> Sure.  Try

@initialize:python@
@@
import pprint

@find@
expression E;
position P;
@@
a();
...
b@P(E);

@script:python display@
places << find.P;
@@
pprint.pprint(places)



> int main() {
>   a();
>   if (x)
>     b(1);
>   else
>     b(2);
>   return 0;
> }

Test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch test-exam=
ple-20231124.cocci example-Julia_Lawall-20231124.c
=E2=80=A6
(<coccilib.elems.Location instance at 0x7ffbc3d2b910>,
 <coccilib.elems.Location instance at 0x7ffbc3d2e500>)


>> * Would it be possible to restrict the transferred data amount by a rel=
ated
>>   metavariable type?
>
> I see no point in providing new functionality to do this.

Can any other SmPL script developers convince you better (than me)
about corresponding possibilities for data processing adjustments?

I would occasionally appreciate if fields like =E2=80=9Cline_end=E2=80=9D =
and =E2=80=9Ccolumn_end=E2=80=9D
can be omitted from the data exchange.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/8d66511d00b27de44e5c2=
1b60d41938d32321b1a/python/python_documentation.md#coccimake_positionfl-fn=
-startl-startc-endl-endc

Regards,
Markus
