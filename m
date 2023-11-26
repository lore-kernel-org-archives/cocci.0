Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F02C4167B
	for <cocci@archiver.kernel.org>; Sun, 26 Nov 2023 14:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=t5iytp577P2Hcq/rRkkoguBlrkX9OXcHw76B04r/dmk=;
  b=q6DaIc3BeOt1cIKuuU8lv1hn5UdPGkvvk5S3RH+WyDFn4RO3fqvCIx1u
   CziPeUIcsjweymob0gvrw1B+ueJU9GlnoThOT0GEQFuW5O8hKPfIK7h1Q
   hJNe/Qo2y8iT9z4+g8GASw5hrCG8paZVt4pgbugJJyZS6ELApRQl7MWEX
   k=;
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
X-IronPort-AV: E=Sophos;i="6.04,228,1695679200"; 
   d="scan'208";a="138574162"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Nov 2023 15:55:44 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EBEEDE0CCC; Sun, 26 Nov 2023 15:55:43 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id DB36BE004E
	for <cocci@sympa.inria.fr>; Sun, 26 Nov 2023 15:55:35 +0100 (CET)
IronPort-SDR: 65635c67_1D/VGTNAZq3B+oqUBJqJqVHXqL60EjDOwXENoBXLIxVvobp
 5cTqy1GBoO0CjBoPxN3s08oRYdx7WZZU+a5IxFw==
X-IPAS-Result: =?us-ascii?q?A0HkBQBTW2Nlhw4P49RaHgEBCxIMQIFEC4I5gVAwBAtIh?=
 =?us-ascii?q?FORMjCEO4c0kDmDFj4PAQMBDUEBAgQBAQMEhH8ChykCHgcBBDMGDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQAQEBIxcHDgoBBSeFaA2CXAEQg?=
 =?us-ascii?q?QyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR0IBAgIBIx0BAREnDwsaAiYCAlcGA?=
 =?us-ascii?q?RQBAYJ8gioBAw4jB6tGgTKBAYIJAQEGr1UfLCJWgV8JgRouiA0BhVmENScPg?=
 =?us-ascii?q?VVEgTyCUjE+hEODW4Jog26FOgeGJYR1igZdIgVCcBsDBwN/DysHBC0bBwYJF?=
 =?us-ascii?q?BgVIwZRBCghCRMSPgSBYoFRCn8/Dw4Rgj8rNjYZSIJbFQw0BEZ2ECoEFBeBE?=
 =?us-ascii?q?gRqGxIeNxESFw0DCHQdAhEjPAMFAwQzChINCyEFVgNFBkkLAwIaBQMDBIEzB?=
 =?us-ascii?q?Q0eAhAaBgwpAwMSTQIQFAM7AwMGAwsxAwcpVUQMTwNrHzYJPAsEDB8CGx4NJ?=
 =?us-ascii?q?yUCMkIDCQoFEgIWAyQWBDgRCQsrAy8GOwITDAYGCR4EDgMZKx1AAgELbT01B?=
 =?us-ascii?q?gMLGwY+AiekWIExgXXELDQHgjGBX4FgDJ8jBhMvlyIOBpJPiBmQJyCoNIF5J?=
 =?us-ascii?q?IFcMxokT4JnTwMZD44gGYQSj0dANTsCBwEKAQEDCYVGAQGDWoFAAQE?=
IronPort-PHdr: A9a23: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
 zYphwE4bel/rF8EDH8oK1CMqCZiySEM
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:gPhnxa/rn+xLXQOY4vduk+AGI+orL9Y04lQ7vn2ZOiYlF/Bw8P
 re5cjztCWE7gr5PUtKpTnuAsa9qB/nhPpICMwqTNCftWrd1ldATrsP0WKK+VSJdhEWtNQtt5
 uIGJIfNDSfNykYse/HwE2fD8sqxsWB/ZulnOHE0h5WPHtXgu1bjjuQEWygYzVLreR9dOEE/B
 Hw3KB6mwY=
X-Talos-CUID: 9a23:Zxb3PWDEjRT+d2L6Eywk2RUqPs0LSET693v6G3KTLDxQUrLAHA==
X-Talos-MUID: 9a23:7dGo/wvQDy162ws3cc2nwzIlP+Z5yquXGVlRiKgkm8yuOCh3JGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,228,1695679200"; 
   d="scan'208";a="72608229"
X-MGA-submission: =?us-ascii?q?MDEm5ANc2j9OY6HJ3xZMcJopFm5yy1Xy3U8IA1?=
 =?us-ascii?q?EctOiE5TMucUxTBJsCsvrUAC8PuiHb+XsREjPs0+VfBANPmzX09iHvxf?=
 =?us-ascii?q?MSG6TpNi+uGdTutqdb2KvSluq5y9gJ0kFcrJpuw3MN+3Z5JRRCsUz3+j?=
 =?us-ascii?q?Byur+okdofuFGda9FVulHnCA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 15:55:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1701010534; x=1701615334; i=markus.elfring@web.de;
	bh=M0RhuBN23kis8r6WVhmaNEUrxLjjND8HhZmotI4fYB8=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=hvmCLd648vop2et5ADiMCZLVFjumoU7eJghrNKdUlaUIpO1wDjFzuQzZfsYFon6n
	 aR9vuPqo8kxsniADl+HFMoxwx0QYOEOL84uMOUVRLu4lJm4nMDHlaCJVXSRKO0v1j
	 WMkc94X3tgz/q+lTBroS139PhYCb5KuHdmW+/WjqiOzX7PbM6TODYuseBktklaMc3
	 DekqcO8SUOv5BYmtgwlEzIhVPy4Hsr0uKiz2PFjGK6+ep/imE63F9ds09QAoAM/qU
	 DKi4auqkhXJPPCz/aWWjSQoGYFkxof6NcI5Og0T1DJyugCEWDUDANWgCBfps2el7w
	 2Ebi+7mVaW7oCN1NVA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8mzy-1rL6CB3vLK-0161XI; Sun, 26
 Nov 2023 15:55:33 +0100
Message-ID: <1d511f1f-4cab-433f-90dc-a6f4e9d3fa7f@web.de>
Date: Sun, 26 Nov 2023 15:55:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>,
 Thierry Martinez <Thierry.Martinez@inria.fr>, cocci@inria.fr
References: <7b59cdf8-5850-49b0-8f91-16d67bf39595@web.de>
 <alpine.DEB.2.22.394.2311240807170.3349@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2311240807170.3349@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UrigpA8VOegDhq8PX0xwOHfPl20roQw75cZ7haWSiY5OLLdarQt
 kfHzou1n50BPeBFgDh3ZK5q5RgmHdFWzSmqTELYtbBQQZ8lt9z5Bk1jgN0S2Dx+lNqgoSpm
 WE8jTFd9WTkbhwsEEWnLzT4xGuonApYkLe+bMqNhGmYuWglNxJVKrL6RByuJp/uoZZk4amI
 /zmCDVOPx0lhJY88qSw9g==
UI-OutboundReport: notjunk:1;M01:P0:btHDYmZIJKA=;WqlR06sLw7uXHHhKa9pzG/xuEie
 9XTgZt/5DfN/hUbs7X/08I3CS+M3RYxwq+/nA84bBjGwD94u4fDLIO5woo/tEu1eZ+xfdqDtq
 abaAbzkcrqvGvKiBzZZagwOLnXyoop8nbA0y2zkAZV3xQyDWuqEg7QXSLMiV3IzfnGz4WVhYl
 JdZPkYW0kq+YmOctuUOgnfjt0CZD5q6VkL/vsTIIGbT3ju7Y1f5u9gvIGn6yVhR4bko9k0MIH
 Rp6Fi+2fqIZLjRfM1P42UZ7zzxmEOCQel5w3o7om/dU0Wp5dGHEb57zPMMoSh9tIqpfxiJ8XI
 8P0U+WniS7AHlCErdPfLm3hpL6zeYL7zFk0lpJVwNUPkzX0/86dDjNv9KpQjO6BksqtrI4j2g
 RlsVOD8Fls/39OYZ/OzTQUVihPS2SWxUhmUv3DhzSvZrosoJHCbkWtPxDtlUgGenW+YpWU5Pa
 BxvnA0YGB7t81NtfgzF5/rUKhk+ykQRcAJTGr84YlLiVsv8Zr/IlMZVaw/+nc1V36QnTGQ+M7
 N0cxlo1xdwLL7WYsI9ZWDQOmtbGiJFuyV+N6ShyXyBWJH2KvIxYwwEO9ZpSfHJV+RAKUiGo/l
 uiTQh2FUIIx7z+2iRm6B3v6wjGK+4VYbdr61tAmYGqysy16rUKx0apLeApnmIqadNzQNkhtbz
 OQLjqSc7Aey7Yiu4nu0ZETROqMgO5fA6oAmiAGlTmg1o68+L21TAbytuUuQXF2muOCugGnaXp
 mhmaerWdlHjJYfkuRXXkVX1zUKqoIVfWodXMC/H3508JrBpKUEXqwMlI5vkchmHwOSCAhivA5
 rI30n7rYirf0Ru+FV2uXe7UstKPxEBzlARcWnqHjqJsm2i0xvmN98OcJWBG/FF9+hL4NjQT2U
 lWkdSIwT+FIYQYq1CaGB84emWSsHSS4Luci6Nni1aGqKm9GslnoAWTLfCzrwLF8Rk+Q0akE5l
 Dlpaog==
Subject: Re: [cocci] Rechecking Python mapping for position variables
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1336
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/1d511f1f-4cab-433f-90dc-a6f4e9d3fa7f%40web.de>

>> Test result:
>> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch displa=
y_position_information_for_one_return.cocci only_return_from_main.c
>> =E2=80=A6
>> (<coccilib.elems.Location instance at 0x7f8fc4fcefa0>,)
>
> The type of a position variable in python is an array.  In OCaml it is
> a list.  This is completely independent of the number of element involve=
d.

The terms differ for the applied data structures with the involved
programming languages.

Another SmPL script example:
@initialize:python@
@@
import inspect, pprint, sys

def display_members(item):
   sys.stdout.write("\n=3D=3D=3D\n\n")

   for member in inspect.getmembers(item):
      pprint.pprint(member)

@find@
position pos;
@@
 return@pos ...;

@script:python display@
places << find.pos;
@@
pprint.pprint(places)

for place in places:
   display_members(place)



Test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch display_p=
osition_information_for_one_return2.cocci only_return_from_main.c
=E2=80=A6
(<coccilib.elems.Location instance at 0x7f6c9a2fefa0>,)

=3D=3D=3D

('__doc__', None)
('__init__',
 <bound method Location.__init__ of <coccilib.elems.Location instance at 0=
x7f6c9a2fefa0>>)
('__module__', 'coccilib.elems')
('column', '1')
('column_end', '7')
('current_element', 'main')
('current_element_column', '0')
('current_element_column_end', '1')
('current_element_line', '1')
('current_element_line_end', '4')
('file', 'only_return_from_main.c')
('line', '3')
('line_end', '3')



Would you like to reconsider the representation of shown number attributes
as text strings (instead of integers)?

How do you think about to enable the usage of an integral data type here?

Regards,
Markus
