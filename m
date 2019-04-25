Return-Path: <SRS0=CDLA=S3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FC9C43219
	for <cocci@archiver.kernel.org>; Thu, 25 Apr 2019 18:13:04 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A857920685
	for <cocci@archiver.kernel.org>; Thu, 25 Apr 2019 18:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Wju0WaFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A857920685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3PICkle029039
          ; Thu, 25 Apr 2019 20:12:46 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 327C9773E;
	Thu, 25 Apr 2019 20:12:46 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 638F1773D
 for <cocci@systeme.lip6.fr>; Thu, 25 Apr 2019 20:12:44 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3PIChOU007907
 for <cocci@systeme.lip6.fr>; Thu, 25 Apr 2019 20:12:43 +0200 (CEST)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1556215962;
 bh=d/yUWaaj1BQM8MRt5tv9qfmv2HpfcKowwNGaJzRs/l0=;
 h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
 b=Wju0WaFQtTWJeOFKvr7AvY+TXoBDwbsZytj3S88nOP0IKmXeFOtcLdV3qkkMoHhVa
 WFsgymMEHx6Yu6GRa3KqRRnL3Ke56f4ObU/NdHKidyODFawLK8TBDMVuxlacoqlQ/u
 Yb2YCwgkIikIfoJYpp9J6hJ1gr1qUl/DKX3SbnMY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.179.241]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LrsGE-1gfKey2HFO-013iDs for
 <cocci@systeme.lip6.fr>; Thu, 25 Apr 2019 20:12:42 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: Coccinelle <cocci@systeme.lip6.fr>
References: <bed744fe-5c5c-cf28-f8b2-40a487709010@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7e81a1eb-fa6b-46ff-7b17-e4d0b84d246d@web.de>
Date: Thu, 25 Apr 2019 20:12:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bed744fe-5c5c-cf28-f8b2-40a487709010@web.de>
Content-Type: multipart/mixed; boundary="------------FDAF50829AA20142181AD2F1"
Content-Language: en-GB
X-Provags-ID: V03:K1:YVhUUNXqwMVBh8JXH3PhMqEXEkAA1eWUcdiNnZNylLey6x4z3v2
 NQbqpEGPpUzhVqTOqBtO50bpIHkHiE6wyFLxIoj4YRhoP2ZUq0KUsa3lBpAULeBvZaNuPj9
 Q10Aeixv0j5ubYGK7+/ffc0Ml3mE27ApQNqUYY7YxxkEE1+iQTyV+/AJTXChA7gRRbdT/Gw
 tEf/rHaRv8W4icVeOWSVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B/FT2L7tBkc=:TNMHP8GguQT1mF5WMItl0u
 c5Q43Ocpe5vufRrEWqwej7ALO4C67Ff2hgl+4+RSP1YTfACyrFwyqmH7pIhQNHrVWCXoFMBf2
 QykUNxacpQi5Mf4RiRRUMEKVMjCfbQF5uhLs+46ZhHkqHtFcx/CkAnQl0LkMYkG3ancGgdv8H
 yQlp/IWjQ3xRKfjiGyVfK78/8udKdHcykcKr/dmprGk3GEsclA5WjcX4Gjr69ZiA6fRWaTBdg
 k239lKkvEO0hzimVGb/ZHKq+LcBF41dLlOag/1gRFOSh0kYnXo2F+SGsU+nJUMfbes255OlIO
 S4H1M/xnQ+ELuCx4Fo5voShMFR11Yk4ihTde2bJ3RiKTu4bhOElg+9JIEX0X47m8pSfUt9Ll0
 EhpE/1580G6pjwvWjoGNFjsdT7AzQsvwJsLEwQC6VeWjyQEQLiOGPnRFgBCTvSdEnAlRn0PCf
 8tR9HggQBfsOaQMaLMU+TkWC3OKqzrtQ/1BpeaUGeoF3M4OJ2ebgUpWBhvOJOZ5TYDH7q9PNv
 yijNGnx9oHZctO5jPS0NW3XYy/q8vFfdAUaE1jKuryLFgibWvBVap/1H8qulkElDfHlWMeMPB
 onQU3Tp9wMRzpQh7bWIM7FPM6Ry3tyteefNDnJPbErG3b8UKSmHG2+7a9W1N7KX4dtH/Y5NAk
 oOathVlRX2gao8F1vxk0U+vntPRAF1Ek1B7avZ1tFmbFqLTOsq8Q5afoQ3UKngaego6AzgDsB
 nzPKTMbmUlfaM4Kd+oqsCG20hjNFLCGsC2u4NiEEeEYopnesrNNUN2morUxlEX99SAYtUix8K
 0ovNffvaZ1HGJ31l1/cLIZo/CiDNoIILXmwu2bIcUC+BDU9D+NF5xGeyh/8LmbFt02Ow7J7d3
 1px/Z6Dr8BuFzUlKQ3c9NWgyyB69CC3e96Z3z2hDAMZOV4bPtNvi3oO6fZSfPo
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 25 Apr 2019 20:12:47 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 25 Apr 2019 20:12:43 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Data exchange through message queue interfaces by SmPL
	scripts
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
--------------FDAF50829AA20142181AD2F1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Is there still a need to perform parallelisation for the mentioned softw=
are
> components by other approaches?

The multi-processing support by the Coccinelle software triggers some
development challenges.
If data should be shared between started (background) processes,
an external system need to be selected for the desired storage service.
I got into the mood then to send these data eventually also through evolvi=
ng
message queue interfaces as the attached script for the semantic patch lan=
guage
demonstrates another data processing approach.


elfring@Sonne:~/Projekte/Linux/next-patched> spatch ~/Projekte/Coccinelle/=
janitor/list_duplicate_statement_pairs_from_if_branches10.cocci drivers/me=
dia/dvb-frontends/stv0297.c
=E2=80=A6
statement1|statement2|"function name"|"source file"|incidence
dprintk ( "%s: readreg error (reg =3D=3D 0x%02x, ret =3D=3D %i)\n" , __fun=
c__ , reg , ret ) ;|return - 1 ;|stv0297_readreg|drivers/media/dvb-fronten=
ds/stv0297.c|3
dprintk ( "%s: readreg error (reg =3D=3D 0x%02x, ret =3D=3D %i)\n" , __fun=
c__ , reg1 , ret ) ;|return - 1 ;|stv0297_readregs|drivers/media/dvb-front=
ends/stv0297.c|3


Such a simple test case works because it stays within known default system=
 limits.
If more questionable source code combinations should be analysed,
it can be needed to increase the configuration parameter =E2=80=9Cmsg_max=
=E2=80=9D considerably.
How do you think about to try any further fine-tuning out in affected area=
s?

Regards,
Markus

--------------FDAF50829AA20142181AD2F1
Content-Type: text/plain; charset=UTF-8;
 name="list_duplicate_statement_pairs_from_if_branches10.cocci"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="list_duplicate_statement_pairs_from_if_branches10.cocci"

QGluaXRpYWxpemU6cHl0aG9uQApAQAppbXBvcnQgaW8sIHBvc2l4X2lwYywganNvbiwgc3lz
CnN5cy5zdGRlcnIud3JpdGUoIkNyZWF0aW9uIG9mIGEgbWVzc2FnZSBxdWV1ZVxuIgogICAg
ICAgICAgICAgICAgICJRVUVVRV9NRVNTQUdFU19NQVhfREVGQVVMVDogJWRcbiIKICAgICAg
ICAgICAgICAgICAlIChwb3NpeF9pcGMuUVVFVUVfTUVTU0FHRVNfTUFYX0RFRkFVTFQpKQoj
IFNlZSBhbHNvOgojICogbWFuIG1xX292ZXJ2aWV3CiMgKiBodHRwczovL3N0YWNrb3ZlcmZs
b3cuY29tL3F1ZXN0aW9ucy8zMjc1NzA0Ni9pcy1pdC1wb3NzaWJsZS10by1vcGVuLW1lc3Nh
Z2UtcXVldWUtaW4tbGludXgtd2l0aC1odWdlLW51bWJlci1vZi1lbGVtZW50cwptcSA9IHBv
c2l4X2lwYy5NZXNzYWdlUXVldWUoTm9uZSwgcG9zaXhfaXBjLk9fQ1JFWCkKc3lzLnN0ZGVy
ci53cml0ZSgiQSBtZXNzYWdlIHF1ZXVlIHdhcyBjcmVhdGVkLlxuIikKCmRlZiBzdG9yZV9z
dGF0ZW1lbnRzKGZ1biwgc291cmNlLCBzMSwgczIpOgogICAgIiIiU2VuZCBkYXRhIGZvciB0
aGUgc2VydmljZS4iIiIKICAgIHJlY29yZHMgPSBbXQoKICAgIGZvciBwbGFjZSBpbiBzb3Vy
Y2U6CiAgICAgICByZWNvcmRzLmFwcGVuZCgneyJuYW1lIjolcywiZmlsZSI6JXMsImxpbmUi
OiVzLCJjb2x1bW4iOiVzLCJzMSI6JXMsInMyIjolc30nCiAgICAgICAgICAgICAgICAgICAg
ICAlIChqc29uLmR1bXBzKGZ1biksCiAgICAgICAgICAgICAgICAgICAgICAgICBqc29uLmR1
bXBzKHBsYWNlLmZpbGUpLAogICAgICAgICAgICAgICAgICAgICAgICAganNvbi5kdW1wcyhw
bGFjZS5saW5lKSwKICAgICAgICAgICAgICAgICAgICAgICAgIGpzb24uZHVtcHMoaW50KHBs
YWNlLmNvbHVtbikgKyAxKSwKICAgICAgICAgICAgICAgICAgICAgICAgIGpzb24uZHVtcHMo
czEpLAogICAgICAgICAgICAgICAgICAgICAgICAganNvbi5kdW1wcyhzMikpKQoKICAgIHJl
c3VsdCA9ICJbXG4iCiAgICByZXN1bHQgKz0gIixcbiIuam9pbihyZWNvcmRzKQogICAgcmVz
dWx0ICs9ICJcbl0iCiAgICBtcS5zZW5kKGJ5dGVzKHJlc3VsdCksIDApCgpAc2VhcmNoaW5n
IGV4aXN0c0AKaWRlbnRpZmllciB3b3JrOwpzdGF0ZW1lbnQgczEsIHMyOwpwb3NpdGlvbiBw
b3M7CnR5cGUgVDsKQEAKIFQgd29yayguLi4pCiB7CiAuLi4gd2hlbiBhbnkKIGlmICguLi4p
CiB7CiAuLi4gd2hlbiBhbnkKIHMxQHBvcwogczIKIH0KIC4uLiB3aGVuIGFueQogfQoKQHNj
cmlwdDpweXRob24gY29sbGVjdGlvbkAKZnVuIDw8IHNlYXJjaGluZy53b3JrOwpzMSA8PCBz
ZWFyY2hpbmcuczE7CnMyIDw8IHNlYXJjaGluZy5zMjsKcGxhY2UgPDwgc2VhcmNoaW5nLnBv
czsKQEAKc3RvcmVfc3RhdGVtZW50cyhmdW4sIHBsYWNlLCBzMSwgczIpCgpAZmluYWxpemU6
cHl0aG9uQApAQAppZiBtcS5jdXJyZW50X21lc3NhZ2VzID4gMDoKICAgbWFwcGluZyA9IHt9
CgogICBkZWYgaW5zZXJ0KHgpOgogICAgICAgIiIiQWRkIGRhdGEgdG8gYW4gaW50ZXJuYWwg
dGFibGUuIiIiCiAgICAgICBrZXkgPSB4WyJuYW1lIl0sIHhbImZpbGUiXSwgeFsibGluZSJd
LCB4WyJjb2x1bW4iXQogICAgICAgaWYga2V5IGluIG1hcHBpbmc6CiAgICAgICAgICBzeXMu
c3RkZXJyLndyaXRlKCIiIkEgZHVwbGljYXRlIGtleSB3YXMgcGFzc2VkLgpmdW5jdGlvbjog
JXMKZmlsZTogJXMKbGluZTogJXMKY29sdW1uOiAlZAoiIiIgJSBrZXkpCiAgICAgICAgICBy
YWlzZSBSdW50aW1lRXJyb3IKICAgICAgIGVsc2U6CiAgICAgICAgICBtYXBwaW5nW2tleV0g
PSB4WyJzMSJdLCB4WyJzMiJdCgogICBkZWYgZGF0YV9pbXBvcnQoKToKICAgICAgd2hpbGUg
VHJ1ZToKICAgICAgICAgdHJ5OgogICAgICAgICAgICBmb3IgdiBpbiBqc29uLmxvYWRzKG1x
LnJlY2VpdmUoMClbMF0pOgogICAgICAgICAgICAgICBpbnNlcnQodikKICAgICAgICAgZXhj
ZXB0IHBvc2l4X2lwYy5CdXN5RXJyb3I6CiAgICAgICAgICAgIGJyZWFrCgogICBkYXRhX2lt
cG9ydCgpCiAgIGZyb20gY29sbGVjdGlvbnMgaW1wb3J0IENvdW50ZXIKICAgY291bnRzID0g
Q291bnRlcigpCgogICBmb3IgaywgdiBpbiBtYXBwaW5nLml0ZW1zKCk6CiAgICAgIGNvdW50
c1sodlswXSwgdlsxXSwga1swXSwga1sxXSldICs9IDEKCiAgIGRlbGltaXRlciA9ICJ8Igog
ICBkdXBsaWNhdGVzID0ge30KCiAgIGZvciBrLCB2IGluIGNvdW50cy5pdGVtcygpOgogICAg
ICBpZiB2ID4gMToKICAgICAgICAgZHVwbGljYXRlc1trXSA9IHYKCiAgIGlmIGxlbihkdXBs
aWNhdGVzLmtleXMoKSkgPiAwOgogICAgICBzeXMuc3Rkb3V0LndyaXRlKGRlbGltaXRlci5q
b2luKFsic3RhdGVtZW50MSIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICJzdGF0ZW1lbnQyIiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgJyJmdW5jdGlvbiBuYW1lIicsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICcic291cmNlIGZpbGUiJywKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgImluY2lkZW5jZSJdKSkKICAgICAgc3lzLnN0ZG91dC53cml0ZSgiXHJcbiIp
CgogICAgICBmb3IgaywgdiBpbiBkdXBsaWNhdGVzLml0ZW1zKCk6CiAgICAgICAgIHN5cy5z
dGRvdXQud3JpdGUoZGVsaW1pdGVyLmpvaW4oW2tbMF0sIGtbMV0sIGtbMl0sIGtbM10sIHN0
cih2KV0pKQogICAgICAgICBzeXMuc3Rkb3V0LndyaXRlKCJcclxuIikKICAgZWxzZToKICAg
ICAgc3lzLnN0ZGVyci53cml0ZSgiRHVwbGljYXRlIHN0YXRlbWVudHMgd2VyZSBub3QgZGV0
ZXJtaW5lZCBmcm9tICIKICAgICAgICAgICAgICAgICAgICAgICArIHN0cihsZW4ocmVjb3Jk
cykpICsgIiByZWNvcmRzLlxuIikKICAgICAgc3lzLnN0ZGVyci53cml0ZShkZWxpbWl0ZXIu
am9pbihbInN0YXRlbWVudDEiLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAic3RhdGVtZW50MiIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICciZnVuY3Rpb24gbmFtZSInLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAnInNvdXJjZSBmaWxlIicsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICJsaW5lIl0pKQogICAgICBzeXMuc3RkZXJyLndyaXRlKCJcclxuIikKCiAg
ICAgIGZvciBrLCB2IGluIGNvdW50cy5pdGVtcygpOgogICAgICAgICBzeXMuc3Rkb3V0Lndy
aXRlKGRlbGltaXRlci5qb2luKFt2WzBdLCB2WzFdLCBrWzFdLCBrWzBdLCBrWzJdXSkpCiAg
ICAgICAgIHN5cy5zdGRlcnIud3JpdGUoIlxyXG4iKQplbHNlOgogICBzeXMuc3RkZXJyLndy
aXRlKCJObyByZXN1bHQgZm9yIHRoaXMgYW5hbHlzaXMhXG4iKQo=
--------------FDAF50829AA20142181AD2F1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--------------FDAF50829AA20142181AD2F1--
