Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC75EC4345F
	for <cocci@archiver.kernel.org>; Thu,  2 May 2024 17:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=IlFgj/rmFI0adokIFBY15jBGZQrDUryr5OGCUQ+6kIw=;
  b=ZHWZkygmRFYrJGbmhRSmDCSoD8wLg5np95dzfBm+qpoN+p6q6c8hMLkr
   c8M3duMmtXwG7GVo6Jcgi1MRu4v3+wvVQWNWSAI1dQGhbmWqALE8gkwTa
   jcO3fVvOc7BcJ84zP0VMwm9XBrHebqnIR8Ft1Jv2BUiONR+CIZRwWBhC8
   o=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@redhat.com
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; 
   d="scan'208";a="164277925"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 May 2024 19:19:36 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4F41BE0035; Thu,  2 May 2024 19:19:36 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1C9FAE0035
	for <cocci@sympa.inria.fr>; Thu,  2 May 2024 19:19:35 +0200 (CEST)
IronPort-SDR: 6633cb26_IsfmhcmuWjZs/VDm916rZpYfxhqL5KNWGGwDDw9Iab6BDll
 TTBlquV9mD/XSZv//kpd2uru9Dpi9SvVvu/8SNA==
X-IPAS-Result: =?us-ascii?q?A0FCAADiyTNmh3yBCqpaFgYBAQEBAQEHAQESAQEEBAEBQ?=
 =?us-ascii?q?IE9BQEBCwGCQ3yBCgQLSIglhS2GSppUhVuBQD4PAQMBCwEBOQsEAQEDAQOEf?=
 =?us-ascii?q?wKILgIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?QEBIhcHDhAnhXANgmcRI2tlCTcBAQEBAQEBAQEBAQEBAQEBAQEYAg18AgEDE?=
 =?us-ascii?q?igGAQE3AQ8LRhRINYJeAYJkAxEGqUYBjHUBAQF2gTSBAYIMAQEGgQg+AwsCQ?=
 =?us-ascii?q?03bGQmBSAGILQGJQnonFQaBSUSBFYMqPoFShwaCL5orjERUfRwDWSECEQFVE?=
 =?us-ascii?q?xcLPgkWAhYDGxQEMA8JCyYDKgY2AhIMBgYGWSAWCQQjAwgEAxA0AyBvEQMEG?=
 =?us-ascii?q?gQLB3WBfIE1BBNHgTiJfQyBfYE0KYFOKYQhS2yEC4F4DmKDYYIuHUADC209N?=
 =?us-ascii?q?RQbBiIBoGqEbbMvlQMHA4QTjA6VHgQWM4NyE4FWkV0MOZI3LodYkFyNdIdOk?=
 =?us-ascii?q?xsCCgcXgWsBM4FccBWDIgkJPQMZD44gGYNhhRSYD0I1AjkCBwsBAQMJiSKBS?=
 =?us-ascii?q?AEB?=
IronPort-PHdr: A9a23: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
 IFetqw8
IronPort-Data: A9a23:T0bwbK+uRvd0eHLeVPDUDrUDNHqTJUtcMsCJ2f8bNWPcYEJGY0x3z
 zYXX2yHM62MZGKgft4gPozjp0NTu5KDxtE3GlBspSpEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHPymYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzA3f7nWYrWo4ow/jb8k834ayo4GlwUmEWPJingneOzxH5M7pEfcldH1OgKqFIE+izQ
 fr0zb3R1gs1KD9wYj8Nuu+TnnwiGtY+DyDW4pZlc/TKbix5m8AH+v1T2Mzwxqtgo27hc9hZk
 L2hvHErIOsjFvWkdO81C3G0H8ziVEHvFXCuzXWX6KSuI0P6n3TE4+peIgI0G4cj/OduUGBNz
 6A/ETVQV0XW7w626OrTpuhEm99mN8z3JMYTt3Vh0zzDHLN/G8yFRqTP6NRRxyt2jcdLdRrcT
 5NGMXw2NFKZOUwJYw1LYH49tL/Aan3XaT9frl+OjbA672ja0Ep6172F3N/9I4LWH5oKzxzDz
 o7A12T7IhxBMYzP8z/f7mORls/kgBvCSqtHQdVU8dYx3QTCmTxCYPEMbnOwpvKyi2alStdHI
 goV/DAvpO487iSWosLVQgb9u3uYplsQVt5RDeAg+UTUkPaS5gecC2MNVSIHY9sj3CMredA0/
 n+Wr/2qBxpli7uUUCOc9Y3Iigq3ZBFAeAfuehQ4ZQcC5tDipqQ6gRTOUstvHcaJYjvdRmGYL
 9ei83ZWulkDsfPnwZlX6rwuvt5BjoXSCxUw+h2SUm+h7x10fp/gPtb0r13a6PtLJZ2FCFKGu
 RDoevRyDsheVPlhdwTUEY3h+Y1FAd7YbFUwZnYyRPEcG8yFoSLLQGypyGgWyL1VGsgFYyT1R
 0TYpBlc4pReVFPzMvYrPtLhUJV0lPW9fTgAahwyRoUVCnSWXFDdlByCmWbLt4wQuBF2y/FvU
 XtlWZr9UR729piLPBLtGr5Mju96rszP7WbSQJ3wxg+7mbyZfmKVAb4APUGPZelx7aWPyDg5A
 P4AX/ZmPy53CbWkCgGOqdB7BQlTcRATW8usw+QJLbHrH+aTMDp8YxMn6eh9INMNcmU8vrugw
 0xRrWcCmQKl2y2ceFnXAp2hAZu2NatCQbsAFXREFT6VN7ILOO5DNY9GL8NpL4o0vvdu1+B1R
 PQjcsCNSKYHADfe9jhXKdG3oIV+fV75zUiDLgi0UggZJpRAfg3u/sO7Xw3N8CJVMDG7m/Fjq
 JKd1yTaY6E5eSJcMOjsZsmC9WiB5UompLoqXm/jAMViR0H3wY07dw3zlqAWJu8PGzXixxyb9
 RekPi0flNn0vr5vocXohL+FnaitAeBRDkpXJEiFzLeUZA3x3Huv/p9Ea8mMJQvibWLT/L6zQ
 9lVw9XXEuw1rHwTv6VSS79UnL8Dvf3xrLpk/yFYNXTsbWXzLIh/I3ODjPJ9hocUypB34QKJC
 1+yoP9EMrC0OeTgIl4bBCwhSs+hjfg0uD3j3c4ZEXXAxh1c3eS4CB1JHhy2liZiAqN/M9olz
 ccfqccm0VGDpSRwAOmWrBJ/1jqqFWMBYZUFp5tBIY7MiygX8H9gT6HYKBfL5MCoV40RHGgse
 iSZlYjTtYR6n0DiSUc+JVLJ/OhahKkNhix08U8/Fwy3veTB19AK30x30DUoTw5q4A1N/MBtN
 0NKaUBkB6W80A15pcpEXmupJQJIKzPB3knX1VEytXb4SnOwXTfnN1wNOueq/WEY/VlDfzNdw
 qqq9Wb9XRvuf+DzxiEXW3M5m8f8TNd0yBLOqPqnE+uBAZM+Rzjv2Y2qWkYltDrlBpkXqHDch
 Ow34tt1V7L3BRQQr4I/FYOe87YaEzKABW5aRMBe7LE7Jn7ddB6yyAqxBRiIIO0VHMPz8Gi8F
 8BKDeBMXU7n1C+x8xYqNZRVKLpwxPMU9N4Of43wHlE/spydkyFItazB/S2vlU4pRNRTyfwGE
 L3zTA7bMGKshipzoVTv/e1kIWuzZOcWaDLshN6V9Po7LLNdkeVOX3xr7J6KkSS0CjZ3xzOVo
 wLJWIHOxcNA14lHvtXhA4dDNSqOOPLxU+WEwCWvuI4XNdjkaMT8iBMNplzZLgltZas0We1qn
 4uJrOzI+kPO548rYjqIh7iACKh7ysGgV8VHMs/MDSd7nAnTfOTO8hc862SDBpgRq+xk5+6jX
 BqeVMSrU9wkA/Nx4WJzajdPNDo4EIH1ZfrQnjy8pPGyFRQt6wzLA9e5/3vPb2sAVCs3F7DhK
 w3zqdC8z8t5qdlSORo6GP1WOZ90D1v9U68Addeqlz25DHGts2ySqInZihssxjHaOEaqSP+gz
 8r+eSH/UxCutIXj7tJT6dVytyJKKkdNu7A7e0ZF9uNmjzy/MnU9Et0cFpc7EbBRrD350cDpR
 TPKbVZ6Mx7HYxZ/TUze7ujgDyClPc5fCuehc3ZttwmRZjytDYyNPKp5+20yqz1qcz/k16e8J
 ctY5nT0OQOrz4p0QfoIoMa2mvpj2uiQ00dgFZoRSCAuK0127XQ2OH1d8M5lSDeCCMTRjADHK
 Gw0W21eUQTiExK3FMdldnVcAw1ftzTqp9ntgeFj3/6H07h3DsUZoBE8Bw03+qcOYMQDOPgFQ
 nafq66l/TWNwnJK0Uc2k4tBvEK3YM5n2uCgIaPjTBFUlKa1goji0wXuggJXJPwfFMVj/58xW
 9ViD7XSxKhIFayJ5ICr9A==
IronPort-HdrOrdr: A9a23:GGkZVKDQ+g+wPkTlHemP55DYdb4zR+YMi2TDGXoBKiC9Vvbo6/
 xG/c5rqCMc7Qx7ZJhOo7690cW7IE80sKQFh7X5Xo3SOzUO2lHYSb2KhLGKq1eNdBEWtNQtsZ
 uIGJIOauEYY2IbsS+32njALz6Mq+PrzEgu7t2utUuEmWpRGtpdB2sVMHfiLnFL
X-Talos-CUID: 9a23:hD8Mt2+NtARdSIY/VEGVv24LKu5mcFvX93HROh65Clw1b4SQFGbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3ApKifkg9mT1OlcYnKrlKsoHeQf8dqw6n1DRBdq5B?=
 =?us-ascii?q?cp9i5JQxbJg+knh3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; 
   d="scan'208";a="164277923"
X-MGA-submission: =?us-ascii?q?MDGrMjwKho7Cj/fu1M+HWOUmGZ5bta/Jm1g3Xe?=
 =?us-ascii?q?bonhSrkg5MXq5fI4+07fiZAI2NqU8WWDofzaUTkzsMPnPTgSovWrr2V+?=
 =?us-ascii?q?B5MSAr8Ntfmff4vJNQ1HR9v68ob6epanws3JnMvid1RT/gy4qfhJSZUY?=
 =?us-ascii?q?QxqXsSuVDorF4i4uaALA5BHg=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 19:19:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714670372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IlFgj/rmFI0adokIFBY15jBGZQrDUryr5OGCUQ+6kIw=;
	b=YDiDzrsnIOwn0ZGFGjMMKHgzBi91m5mh/eapQhngc50RoPLk6ocSEjQN4zfmTXSkiM5/Yi
	z6t4urfG+m4NLp7QYw4KTkXsGIIwxfK++BJhCemmBJ6KOdoqWS7X41B+rGXx6NyANYY9vP
	c+HfPj0jnSPnKakTersLvZ7bn8ZbYvQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-Zas1oZI2PdaZ-qju1roYIw-1; Thu,
 02 May 2024 13:19:31 -0400
X-MC-Unique: Zas1oZI2PdaZ-qju1roYIw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C0763C025C7;
	Thu,  2 May 2024 17:19:31 +0000 (UTC)
Received: from localhost (unknown [10.42.28.23])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E062040C5C2;
	Thu,  2 May 2024 17:19:30 +0000 (UTC)
Date: Thu, 2 May 2024 18:19:30 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <20240502171930.GE30267@redhat.com>
References: <20240502085433.GA30267@redhat.com>
 <bf4ca7f1-d732-0fc-1991-f855c0364235@inria.fr>
 <20240502163131.GC30267@redhat.com>
 <6881602e-5f8e-db48-323d-139673441398@inria.fr>
 <20240502164958.GD30267@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20240502164958.GD30267@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [cocci] Very long compile times on
 parsing_cocci/parser_cocci_menhir.ml
Reply-To: "Richard W.M. Jones" <rjones@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 1685
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/20240502171930.GE30267%40redhat.com>

FWIW this is the flamegraph.  It's not very informative, but maybe
means a bit more to people familiar with the internals of the OCaml
compiler.

http://oirase.annexia.org/2024-05-ocamlopt.svg

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v

