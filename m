Return-Path: <SRS0=CDLA=S3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F86C10F03
	for <cocci@archiver.kernel.org>; Thu, 25 Apr 2019 08:06:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A68217D7
	for <cocci@archiver.kernel.org>; Thu, 25 Apr 2019 08:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="SCjzRR2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A68217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3P86D6P017035
          ; Thu, 25 Apr 2019 10:06:13 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 978AB773D;
	Thu, 25 Apr 2019 10:06:13 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E09FF7731
 for <cocci@systeme.lip6.fr>; Thu, 25 Apr 2019 10:06:12 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3P86BoK002854
 for <cocci@systeme.lip6.fr>; Thu, 25 Apr 2019 10:06:11 +0200 (CEST)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1556179571;
 bh=E/zG/OP4tgTuY+LnvVTe+CgYECINXSGDYsesuNVNH1U=;
 h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
 b=SCjzRR2trkCOryez/vpxadkAdZlizUPWLPonW8xkmXBxiqhW3b6yyNcZCmaf2lYY9
 yPo3ez9lmPlmYIbDIhKDdifwYT4ug9e6xWAMZ8/arfBV03/sdXX36HsFEQFSH/mgTp
 MpTIA+/MyQhTbzlFFiXD1JkLI6vor+sKalQT8sPk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.179.241]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MYw31-1hFMEi0SGZ-00VkYp for
 <cocci@systeme.lip6.fr>; Thu, 25 Apr 2019 10:06:11 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: Coccinelle <cocci@systeme.lip6.fr>
References: <bed744fe-5c5c-cf28-f8b2-40a487709010@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <30df39b4-6f45-45c7-1c37-1f8991f3f6e2@web.de>
Date: Thu, 25 Apr 2019 10:06:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bed744fe-5c5c-cf28-f8b2-40a487709010@web.de>
Content-Type: multipart/mixed; boundary="------------62F43997752844A3B043691D"
Content-Language: en-GB
X-Provags-ID: V03:K1:Li08urvnzDzUIhcGF19sZZU8zUwPsRTFKmtXyPqM6aUULqvmRB1
 eFn+9sEhiOO9c8ktu1CVcxMNEL8DfTKe2wh3jXgSDI39Rx3DnnDVJNcqSVlZltiU9lg+oY1
 oilUmFE1aTxdpAFnso+hjCc2flZD3lEMt8bzdnRDNBWQn1C/BuHA3Aue4cmmJBAk4Tpj4jw
 Cqi7vTdIc2UXMyhdzTKqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o2VAjaaonUQ=:PLpsSCvUGKwsZI8FWf7zlu
 apDhvtcpH0m8B8wG/k+E1u4SfSMFV6DI6/xzsiapPReQH0ZvmWrfV14X6MnhEGKeq7xspvEr8
 djtwqDTeDzrIYE7tcsngg16OcEvc4IKmEVs6HVozBnt1ENhjZ9eOT3XVhYeUVZluufxbjYnwA
 OwdIeY4NYiEMrGvHX/2dKmBcOeQSWQS0tcF0DkNWRxq38o3LG18jdVN1s33XUfEgmKWQ9mnbd
 M3Qxxq81laOrHFalOwDEaZ4g6Hsv9jT4P062jnC3VBZAoVCvFTjnon1yM1GGpOftztcnccdlv
 i1OOGm6bWZRzHb2mqbi94hGg8KTVRpl/XxpaRMZkiQ1KWbP24r6j+VOroj3cbfQdsfEGL+btQ
 FqIYshG3uzSVlYALSRojeQXYNBhHnUFpsV3c+bYVY2VtCccCrOVUDBCcc7vejaeOeONMJoMb8
 /cuxM1OxebVQJPFQzwdu51L3AfZdRl7/mR7ffALYK4uebBYvsCuIw+tJUY77dSej8UZwV4bRh
 wFm/EQHPi2xXGjftmxzuyYHufqJz8SEk71KtA5YtrWoMgTi/W3p4HiEid4L0Bh+RChcWFAxGl
 i1VnBe5BtBv+BOoe2vnewcSurAORYoi0RUsWsq0ybbpSPnLxd7zKRRJrEW1tTo32dZ5h3KYWw
 GvdQE9MObv0hbLzgpa5fgSzM8UN+tNXK7KXfirXxVPpk0ZMeS0O/05RbMIA90q6qTqg4E9Yxr
 ZuYa9exe9bFmqMlZnds2xFDPfFNRMG7mcD3lqst48PJReH/wECMuRyUl2uxbizfkZkzqGRW+s
 2/MtFz+1KBHGy+lQgW85g2txNbvsF6VUAmIcEpU7mgpJiAQE4iWLHDpNvt1htN8ZvAT9G1X9Y
 tTkB73B9qThe/XlniyvJqsskyZWQgfwjQgYPAdK+5QHxhci5qYqCYnEwxLcas9
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 25 Apr 2019 10:06:14 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 25 Apr 2019 10:06:11 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Data exchange over network interfaces by SmPL scripts
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

This is a multi-part message in MIME format.
--------------62F43997752844A3B043691D
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Is there still a need to perform parallelisation for the mentioned softw=
are
> components by other approaches?

The multi-processing support by the Coccinelle software triggers some
development challenges.
If data should be shared between started (background) processes,
an external system need to be selected for the desired storage service.
Thus I would like to send these data over network interfaces by the attach=
ed
script for the evolving semantic patch language.

I stumble on the following error message.

elfring@Sonne:~/Projekte/Coccinelle/janitor> /usr/local/bin/spatch -D serv=
er_id=3Dlocalhost -D server_port=3D1234 list_duplicate_statement_pairs_fro=
m_if_branches-client2.cocci ~/Projekte/Linux/next-patched/drivers/media/dv=
b-frontends/stv0297.c
=E2=80=A6
Using Python version:
2.7.15 (default, May 21 2018, 17:53:03) [GCC]
=E2=80=A6
Traceback (most recent call last):
  File "<string>", line 4, in <module>
  File "<string>", line 34, in store_statements
AttributeError: __exit__
Error in Python script, line 55, file =E2=80=A6


I would appreciate if the shown data processing approach can work with
version ranges of involved recent software components.
So I am looking for additional solution ideas.

Regards,
Markus

--------------62F43997752844A3B043691D
Content-Type: text/plain; charset=UTF-8;
 name="list_duplicate_statement_pairs_from_if_branches-client2.cocci"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="list_duplicate_statement_pairs_from_if_branches-client2.cocc";
 filename*1="i"

QGluaXRpYWxpemU6cHl0aG9uQApzZXJ2ZXJfaWQgPDwgdmlydHVhbC5zZXJ2ZXJfaWQ7CnNl
cnZlcl9wb3J0IDw8IHZpcnR1YWwuc2VydmVyX3BvcnQ7CkBACmltcG9ydCBqc29uLCBzb2Nr
ZXQsIHN0cnVjdCwgc3lzCnN5cy5zdGRlcnIud3JpdGUoIlVzaW5nIFB5dGhvbiB2ZXJzaW9u
OlxuJXNcbiIgJSAoc3lzLnZlcnNpb24pKQoKaWYgc2VydmVyX2lkID09IEZhbHNlOgogICBz
ZXJ2ZXJfaWQgPSAibG9jYWxob3N0IgoKaWYgc2VydmVyX3BvcnQgPT0gRmFsc2U6CiAgIHNl
cnZlcl9wb3J0ID0gMTIzNAoKZGVmIHN0b3JlX3N0YXRlbWVudHMoZnVuLCBzb3VyY2UsIHMx
LCBzMik6CiAgICAiIiJTZW5kIGRhdGEgZm9yIHRoZSBzZXJ2aWNlLiIiIgogICAgcmVjb3Jk
cyA9IFtdCgogICAgZm9yIHBsYWNlIGluIHNvdXJjZToKICAgICAgIHJlY29yZHMuYXBwZW5k
KCd7Im5hbWUiOiVzLCJmaWxlIjolcywibGluZSI6JXMsImNvbHVtbiI6JXMsInMxIjolcywi
czIiOiVzfScKICAgICAgICAgICAgICAgICAgICAgICUgKGpzb24uZHVtcHMoZnVuKSwKICAg
ICAgICAgICAgICAgICAgICAgICAgIGpzb24uZHVtcHMocGxhY2UuZmlsZSksCiAgICAgICAg
ICAgICAgICAgICAgICAgICBqc29uLmR1bXBzKHBsYWNlLmxpbmUpLAogICAgICAgICAgICAg
ICAgICAgICAgICAganNvbi5kdW1wcyhpbnQocGxhY2UuY29sdW1uKSArIDEpLAogICAgICAg
ICAgICAgICAgICAgICAgICAganNvbi5kdW1wcyhzMSksCiAgICAgICAgICAgICAgICAgICAg
ICAgICBqc29uLmR1bXBzKHMyKSkpCgogICAgd2l0aCBzb2NrZXQuc29ja2V0KHNvY2tldC5B
Rl9JTkVULCBzb2NrZXQuU09DS19TVFJFQU0pIGFzIHNvOgogICAgICAgICBzby5jb25uZWN0
KChzZXJ2ZXJfaWQsIHNlcnZlcl9wb3J0KSkKICAgICAgICAgcmVzdWx0ID0gIltcbiIKICAg
ICAgICAgcmVzdWx0ICs9ICIsXG4iLmpvaW4ocmVjb3JkcykKICAgICAgICAgcmVzdWx0ICs9
ICJdIgogICAgICAgICBiID0gYnl0ZXMocmVzdWx0KQogICAgICAgICBwID0gc3RydWN0LnBh
Y2soIj5JIiwgbGVuKGIpKQogICAgICAgICBwICs9IGIKICAgICAgICAgc28uc2VuZGFsbChw
KQoKQHNlYXJjaGluZyBleGlzdHNACmlkZW50aWZpZXIgd29yazsKc3RhdGVtZW50IHMxLCBz
MjsKcG9zaXRpb24gcG9zOwp0eXBlIFQ7CkBACiBUIHdvcmsoLi4uKQogewogLi4uIHdoZW4g
YW55CiBpZiAoLi4uKQogewogLi4uIHdoZW4gYW55CiBzMUBwb3MKIHMyCiB9CiAuLi4gd2hl
biBhbnkKIH0KCkBzY3JpcHQ6cHl0aG9uIGNvbGxlY3Rpb25ACmZ1biA8PCBzZWFyY2hpbmcu
d29yazsKczEgPDwgc2VhcmNoaW5nLnMxOwpzMiA8PCBzZWFyY2hpbmcuczI7CnBsYWNlIDw8
IHNlYXJjaGluZy5wb3M7CkBACnN0b3JlX3N0YXRlbWVudHMoZnVuLCBwbGFjZSwgczEsIHMy
KQo=
--------------62F43997752844A3B043691D
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--------------62F43997752844A3B043691D--
