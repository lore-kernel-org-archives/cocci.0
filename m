Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D00D116EA
	for <cocci@archiver.kernel.org>; Sat, 29 Nov 2025 13:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:date:from:to:in-reply-to:references:
   message-id:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=EDMAUfoVMauVxmBjjKIe5HamZ7/d19RkKuT6epLf2R0=;
  b=u3NLBX2i/ufCmBp9LFbhAJFOWn12hzyF+VbAGhY0XR42OZJJ0behznRN
   oqVxrRrRCcErq1rbOBO+W+EDbQku38HC8a7VvAbIxGG3323tv423Vo9PG
   Wd7A8ipu17vmQpFllVmEwsYjjvKk/xKOugzLJUEfzKcrTn81rdCaybq0V
   E=;
X-CSE-ConnectionGUID: 0LG/Z533ROCsygctNL0AQw==
X-CSE-MsgGUID: SiUAQVqiSxqbf/JAKjSF8Q==
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@posteo.de
X-IronPort-AV: E=Sophos;i="6.20,236,1758578400"; 
   d="scan'208";a="251887725"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Nov 2025 14:15:15 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D21C1E0AF1; Sat, 29 Nov 2025 14:15:14 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id F1279E0157
	for <cocci@sympa.inria.fr>; Sat, 29 Nov 2025 14:15:08 +0100 (CET)
X-CSE-ConnectionGUID: K9aHxSPvSx6McOCK+B5yow==
X-CSE-MsgGUID: Cm0JVlsJQumfZNxXre5AtA==
IronPort-SDR: 692af1dc_qny2qzi7Cyy/aC3yP5Hhhy7AL4u0X2mdFB2mjVHxtC8aeKk
 QvFp23n4pom9KBZnNk+H8URDoRK6R8IUCZdAuWw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HwBACE8Cppe0EkQ7laHgEBCxIMQIFSgj6BYDMHCEmEV?=
 =?us-ascii?q?Yh7iHwRkgaOAg8BAwENTwIEAQEDBIFMgzQCjGUCHwYBBDUFDQECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQFCDjuGTw2CW4EsgSYBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEdAiw/AR8BAQEDIxUIAQE4DwsYAgImAgJWIYUdAk8HAbFTgTKBA?=
 =?us-ascii?q?YIMAQEG3CWBZAmBHC+FbYJlAYVehQgnD4FVRIEVgnkxPoRDFTiDDoJpgiaBD?=
 =?us-ascii?q?oYki2+HQywmeBwDWSwBDxE1ExcLBwWBIEMDgQsjDzwFLR2BIyEdGBFgPRdAg?=
 =?us-ascii?q?0kdBmcPBoERGUkCAgIFAkA6gWYiBhwSAgMBAgI6VQyBdwICBIIWfYIKD4gLg?=
 =?us-ascii?q?QkFLoENAwsHZj03FBsGAgE6e5QSUIIoBnwTgXGBMqMIons0B4I4gWeBXgYMn?=
 =?us-ascii?q?28SHBeXYJMLmQapQYIAIoFcTSSDNk8DGQ+OIT6DdcRlQzU8AgcBCgEBAwmFa?=
 =?us-ascii?q?ROMIoFLAQE?=
IronPort-PHdr: A9a23:SDdY7BbdNvBfFYInkkfIBMH/LTFH2YqcDmcuAnoPtbtCf+yZ8oj4O
 wSHvLMx1wSPBdmQsa8e1rGe8/i5HzBbutDZ6zFKWacPfiFGoP1epxYnDs+BBB+zB9/RRAt+M
 eJ8EXRIxDWFC3VTA9v0fFbIo3e/vnY4ExT7MhdpdKyuQtaBx8u42Pqv9JLNfg5GmCSyYa9oL
 BWxsA7dqtQajZFtJ6s/xBbFuGdEdutZyW92JV+fgRbx68mt95Jn7yhcpugt+sFOXKj0Zag0U
 bJVADE7OG0p+cPnsgXOQgSI6nYASGsdjwBGAxLC7BH0X5fxtjX1u+9g0ySEPsP4UK45Vy264
 6lkUBHnhz4LOiA2/m/KksB/g75Vrxynpxxk3o7be5qVO+ZkfqPcZtwVW2xMVdtMWiNbA4O8a
 4wPD/cdPetdsoLwqUcCoQe4CAKxAu7k1z1GiWLs3aAi3OsvHwHI0hI9Ed0MvnTar8n6OqgJX
 OCp1anIzynPY+9K1Tr/7oXDbxAvoeuLXbJ1acff104vGBjEjlqKsozuIj2b2foMs2ie7upgU
 +2vhHA9qwpspTWv2sAshZLIho0P0VDI7zh2z5g0Jd29SU57Z9GkH4VKtyyBL4t2RdgiQ312t
 yY90LEJpIC0cTEMxZ86yBHRd+aJfJKU4hL/SumROzF4iWp7db6hmhq+7Fatx/PgW8S70VtHr
 ypIn9vRun0JyRDd5ceKR/pg8kmhxzqC1B7f5O5EL040m6TWKJ4vz74umpQct0nIAyz4mF3ug
 aOLdUgp+vKk5uXlb7n8qJKRNpV4hwD+P6g2h8CyAuQ1PhIPUmWZ4+ix2rzu8VfkTLhLivA7l
 LTSvorAKsQBvKG5BhdY0oY95Ba7CDeryNEYnX4aLFJZZB6LkpLlO0nJIPDjEfewnVOsnC12y
 P/YJrHhA5PNIWbfkLr5YLpw6E5RxBAywN1d/Z5ZBLAMLOjyV0LxrNDYCwU2Mw2ww+bpEtV90
 YYeVHqTAq+eK6zSsEWH5vk1L+aReoAVuTP9K/kj5/7hk3A5g0QQfbGu3ZsMdHC3APNmL1+Eb
 nXymtsBC3sFvhIiTOz2j12PSSJcZ3GuUK0g5zE2E5mmDIfGRoC1mrONxia7HptMZmBHEF+AC
 3nod5+cV/cKcy2dOtVhnSAcVbi9V48h0gmjuBLix7poMOXU/S4Wu4j72dZ76OPfjQsy+iJqD
 8qeyW+AV2R0nmQVRz8qwKxzvFZxyk+E0ahjn/xXC9tT6+lUXQgkLZLT0u96C9H3Wg/ZZtmHR
 1ipTMu6DzwtSNw928IBY0NnFNW4kh/OxzKkDaYNmbKEHJA06brc33bpKshn13vIybQvg0E9Q
 stXO22pnq5/+BbXB47Oi0iXjbqne7kB0n2FyGDWxm2Ft0BwUQhqUKyDU2pMSFHRqIHF4UnDR
 qTmJbkmNwpHxsOYYv9WbdfohE4ASPriPdXYbG+rs3+3HgqFwfWAYdy5KC0mwCzBBR1cwEgo9
 nGcOF1mbs/Ai2fXDTg1UEnqf1up6u5m7nWyUk4zyQiOKUxnzbu8vBAP1rSHU/1G+LUCtW86r
 ilsWk6n1ofKDNCBrhEncKhdZNI771pd/XrerBBwOdqsIvMqnUYQJjx+pFimzBBrEsNFmMkuo
 mktyV9uLqiZ2UgHez6Z2JH2NbDNAnH15wyibOja1wKWy86Yr58G8+9wsFD/pEepG04lpm1gy
 MVQ2mCA64/iCQ0PTcqoFF4w7AR3oPfWb0HR/qvy0ntheemxuz7GgJcyAfc9jw2nZ5FZOb+FE
 wn7F4sbAdKvIaokgQrhaBVMJ+1U+KMuWqHuP/KbxK6mOvphlzO6nCxG5o56yEeF6yt7TKbBw
 Z8Ex/iS2gbPWS37iR+ttcX+mIYMYj93fCL31S/uBYdKIKF/fIMKD2ijOeWvwc5iipmrV3MZv
 F+vClUa2dO4LAKIZg+Yv0UY3kAWrHq73CqgmmUkznd38ezEgmqQnreHFlJPIGNASWh8gE25J
 IG1i4tfR020d00ykwPj40/mxq9draA5Lm/JQE4OcTKlSgMqGqa2qLeGZNZCrZ0ytiACGvi7a
 1GTUfjxrhof0iXsEnF23Dcgazyt/Jn01U8f6irVPDNooXzVdNsljwvY7t3VXrhd0zsDRS93h
 CP/Hl+nI9Suu9mZ3cSm0Kj2RyeqUZtddjPuxIWLuX6g5GFkNha4mui6htztFQVSPTbT79BxT
 m2IqR/9ZtKuzKGmKad8eVEuAlbg6s18E4U4k40qhZhW12JIzpmS+HMGly/0P7A5keria3AMT
 CVNz9PU5Qnj10B5BmqO3J70UTORz4NtasK7bWUfxi8mp5kaVeHKs/ofw20r/xKxtmezKbBlk
 y0YyOcy5XJSmOwPtAc3j22cDr0UAUhELHnpnhWM4cq5qfYfb2KufL6skUtmyInxUffc/UcHB
 jCnJ8RHf2c49Mh0PVPS3Wem74jlfIKVdtcPrliPlA+GieFJKZU3n/5MhCx9OGu7s2d2roxzx
 RFow5y+u5CKbmt3+6fsSAJfPDz8fIUf9zDojKBRk9y+x4e0AphmXDkGFsiNL7rgAHcJuPLrO
 hzbWiE7oHaSAvzTEA6a6UFpomjnC5ewK3yQYnUUh4YHJlHVNAlUhwYaWy8/l5gyG1WxxcDvR
 0x+4ygY+l/yrhYfgvItLRT0VX3T4Ru5cjphAobKNwJYt0sRgiWdedzb9O94GDtUu4GsvBDYY
 HLOfBxGVCkIQhDWXgC+eOfxo4KetbDfXLHbTbOGYK3Q+7ZXD6raz5n3gNI+p27eZILTYTF0B
 vk/kCKvRFhBEt/C03UKQi0TzGfWatKD4Qy74mtxp9y+9/LiXETu45GOAv1cK4cn9xeziKaFf
 +me4UQxYS5fzY8JzGTUxaI32VkPl3k3MSGqCqgNsmjBQercl7RWABgSdy5ofJIYsuRigU8WZ
 4iF15v8zdsaxrYtBk1AVED9l83hfsEML2yndRvGCEuNKLWaNGjLzsXwMuu3TbxdivkRtgXl4
 GbGVRG8eG/d0We0BHXNealWgSqWPQJTotS4exdpUi34Sc7+Lwa8KJlxhCE3xrs9gjXLM3QdO
 H5yaRAozPXY4CVGj/F4A2EE4GBiKLzOhyGT7uDDbJobsP5qBCt5jcpC528mxrwT4CwOF5kX0
 GPC68VjpV2riLzF0j18TB9HsSpGnqqOulh+Yfyf7p5bRXvDuh4Apzb1aVxCt55uDdvhvLpVw
 97EmffoKTtMxNnT+NMVG8neLM/UeGpkKxfiHyTYSRcUVTP+f3+KnFRTybvBkx/d5oh/sJXnn
 4ACD6NWREBgXO1PEVxrRZQDOMslB2N51+DEypVWoyL59kK0Jo0Sv4iZBKibWai9Ij3B3+AcP
 0Nak/SkcswFP4n/kSSKi3F/m5nWQxOWRddWviBmKAM58hwlGJ1WVmoox0/iLA+gsid7/RGch
 hktlgZ5J+ggpm6E3g==
IronPort-Data: A9a23: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
 Owj
IronPort-HdrOrdr: A9a23:dSwvFaPq60mUdsBcTsijsMiBIKoaSvp037BN7TEXdfU1SL39qy
 nKpp4mPHDP5wr5NEtPpTnEAtjifZq+z/JICOsqTNKftWDd0QPCQb2Kr7GSoQEIcBefygcy78
 ZdT5Q=
X-Talos-CUID: =?us-ascii?q?9a23=3A6+ytbWqSsoP014gk/4rDrYDmUeN0e13N90/OGF/?=
 =?us-ascii?q?mLG1OY57WYwKB/7wxxg=3D=3D?=
X-Talos-MUID: 9a23:lBZnRAn2Y1zZowdWomwHdnpJMZ9K3aC1KnkQlJs0ndm0LyEtEiu02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,236,1758578400"; 
   d="scan'208";a="132280722"
X-MGA-submission: =?us-ascii?q?MDGX+p0no0mSUNWVPWJff+fdza+YEid2OfirOA?=
 =?us-ascii?q?qTN7xZcYf56CB6o1UJ11USjtIOMiXqP9bY8ERUpr18RwCiNqDnFeHm71?=
 =?us-ascii?q?hsliNUQU55AdeQyWOmjsOfBagPmHfwuWg7OlSEOW0vcxFKCAk0Y0uZgw?=
 =?us-ascii?q?BSh92t4//MI5gYRTbyD+6KEg=3D=3D?=
Received: from mout01.posteo.de ([185.67.36.65])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 14:15:08 +0100
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id B3E21240027
	for <cocci@inria.fr>; Sat, 29 Nov 2025 14:15:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1764422106; bh=EDMAUfoVMauVxmBjjKIe5HamZ7/d19RkKuT6epLf2R0=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=X83MbXMc8yUuWIkDTac9cdDFXQFPsbMlyN0nywad/G7V7etx4fn/fFAOGeROCpTLb
	 41UgRdBGC0e4xDbWpZM94IVUg/iXSZWQJfVn0xobwGDA6NAe8b7QrqWBpxQhV2he29
	 TU1z+uttciUOb1lBI819Z7t3XvoxqpyXTvPv0CQ5Qx0HP5d4355IVj6w1eT5PyfJT1
	 1gIXxfG5MUJm5PShuOUBXxvNsmH5cjjcK+BcE0b5WiGidKdzGCq7uWbMNsvZx0fq2Q
	 /2pulD/Mu7RDjwkQcRbJ/SFKHlFJkwbes8asDJqsV7XiOI1y6olsi0ben8RYZ/tbzt
	 6pofAtHi+f1UA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dJVyL2XHWz6v0P
	for <cocci@inria.fr>; Sat, 29 Nov 2025 14:15:06 +0100 (CET)
MIME-Version: 1.0
Date: Sat, 29 Nov 2025 13:15:06 +0000
From: Tobias Deiminger <tobias.deiminger@posteo.de>
To: cocci@inria.fr
In-Reply-To: <b4884a21-4a59-c549-8466-164a20a76abe@inria.fr>
References: <4f6e259891de0666aa1fa10b810a5dd3@posteo.de>
 <b4884a21-4a59-c549-8466-164a20a76abe@inria.fr>
Message-ID: <2897bda0c438111e967017f6bb3422f0@posteo.de>
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] Can we match a known macro by macro name instead of
 expanded function name?
Reply-To: Tobias Deiminger <tobias.deiminger@posteo.de>
X-Loop: cocci@inria.fr
X-Sequence: 3206
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/2897bda0c438111e967017f6bb3422f0%40posteo.de>

Hi Julia,

Am 29.11.2025 11:56 schrieb Julia Lawall:
> On Sat, 29 Nov 2025, Tobias Deiminger wrote:
>=20
>> Hi,
>>=20
>> my newbie assumption was we could match the following by macro name
>>=20
>>   // my.c
>>   SYSCALL_DEFINE0(foo_bar) { return; }
>>=20
>> using this rules
>>=20
>>   // my.cocci
>>   @r@
>>   identifier fn =3D~ "SYSCALL_DEFINE[0-6]+";
>>   position p;
>>   @@
>>   fn@p(...) {...}
>>=20
>>   @script:python@
>>   fn << r.fn;
>>   p << r.p;
>>   @@
>>   print(f"match: {fn} at line {p[0].current_element_line}")
>>=20
>>=20
>> Turns out, SYSCALL_DEFINE0 is a "known macro" from
>> /usr/lib/coccinelle/standard.h. In this case coccinelle seems to match=
=20
>> an
>> identifier on the expanded function name, not the macro name. I.e.,=20
>> this would
>> work:
>>=20
>>   identifier fn =3D~ "foo.*";
>>=20
>> But I really want to search all syscalls by the conventional macro=20
>> names, i.e.
>> search for SYSCALL_DEFINE[0-6]+. How to do that?
>=20
> The problem is that the code won't parse with the conventional macro
> name.  Maybe you could change the macro definition in standard.h to put=
=20
> eg
> __SYSCALL_DEFINE0 in front of the function name?  That would be=20
> considered
> to be an attribute and then you could put __SYSCALL_DEFINE0 as an
> attribute name in your semantic patch.

sorry for having to ask again. Your suggestion sounds very reasonable.=20
But I couldn't figure out how to match on attributes. I guessed it would=20
be something like this

   @r@
   attribute a;
   identifier fn;
   @@

   a fn(...) { ... }

But that gives a .cocci parse error:

   minus: parse error:
     File "my.cocci", line 6, column 2, charpos =3D 38
     around =3D 'fn',
     whole content =3D a fn(...) { ... }

Expected, IIUC, since attribute doesn't occur in fundecl from grammar:

   fundecl ::=3D  [fn_ctype] funinfo * funid ([PARAMSEQ(param, =CE=B5)]) {=
=20
[stmt_seq] }

How else to look for functions with attributes then?

Tobias
