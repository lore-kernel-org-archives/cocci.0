Return-Path: <SRS0=cw0N=6I=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A783C54FD0
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 12:03:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB69320728
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 12:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ZW9f8hIq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB69320728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03OC2rPV000301;
	Fri, 24 Apr 2020 14:02:54 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E00B17827;
	Fri, 24 Apr 2020 14:02:53 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 51A657815
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 14:02:53 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03OC2qPX022632
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 14:02:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587729771;
 bh=uLDCWAbF7TrNmb6JL/KkfLYLOc8CmbX54wZtHf67l/8=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=ZW9f8hIqFse6gyRDTqh6tkiXGe2pVB8gYbUyFHnydjSQVhyTE9TsCupVH3PcRWLF9
 UXBO3acEHlTFKB0yE+bQk5JgZElzU+E96EWj3kTvvCUM6q6ADmOJ9Ee7VsaZtGS8hs
 GvvSZwzFoDBa95GCVKrXrimLbvgA7DHQOL2wopf0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.129.82]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MYf78-1jeYCv1jFa-00VMXu; Fri, 24
 Apr 2020 14:02:51 +0200
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <490913cf-2563-25a5-c977-dadc87da866b@web.de>
Date: Fri, 24 Apr 2020 14:02:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:GEuQZSPc4JpqrM6cmhVf+WuX85vMHR1C+O+xKvwkmykJZvBYFSR
 hWbe53qJKE6ZawyLRa04M4FiDO27Q1Nz74BxskNq2KS263nU1mrcQEGc3gBL08AmdfKhnnc
 amRz+yeTVIMHv8P60LMJMs2qul3q2tyqWfAESfLrgp/D2pkyMerkvfmJ6v8aZHhzDrD/DoV
 VqO7MSDlHazlV5XmHr5GQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J0pCDNIZWcs=:vZOMQOpqvKWiMrRTGXy4qq
 w84ybtNqGIwxynuUcInOgDG5QdwQ8fv8JKNsWrTrVmcl/MbKi7wy9GcCiKFC4xGi3hjqZu7/y
 yLEFEexB64YcONNGSzlSAzYSgeLbsrMVE+ELG+I+BwutWInrtLXmsWgfquE1xvxBA6Xir79C+
 rR3QfY3v1zebis+2xB5ruy/fE2F7UbM+BotG6fCLaGi4q7BHT8+arZ9FSKlyOnfKeU5Bq3aNg
 luUvIfCugdNthKmGWmB1vbBCagWu08uPwRd5R59dm/PcnMbatiZT1Zi0kwI+AdyUA7ToDOc5o
 BxTsag7rFKVOadq1kA2iDJvWEtPqlldMR0CZo2fdJ7/oNaXLLPRB6Xzj2czZVYiF2O0f3dz39
 S0GA/maj+sXLDVHQjov7orENz9efD2zu3Wg+4W7gXQYLtR0NDVbSFjJb30XCHq1A9LRyQZsBH
 +Gy/oPwNicdmhBC4aO0fFCKZrIMnk6Gy2YGc2tTvJHx3MmC5TuUKtY++eswZlr9oeubKH5lfH
 ItUbqc8KYrjIA6CXucJnmvGyGfjgY5QfJI50FxuV5QOvJPAWuY8v73IvDXmDQnVR4Usrpscst
 c9R/NNf4EoB7uoYYJPJhfRT0xQMywS3WL3ovQd91QE3td280PwcAeAXl8lHM1o9zU6ibtTVwT
 ruywBEQeFN6rzRVq3vA/pLQGrd0cugxrqd58bAJFPjgoW18D1YJGualgi5HmvDYwtF6yt9r3o
 w0SmR6QmR2Gnm2n879kEUXY93kUDHjXK9udRvla86+jaMwQqxSkKEtb986+TLVF3GkxYNKluu
 wHyxI4XtJquLIiaeXxeqB106/H2CILnhd772nhAWw4J2X8M3LnZVcjcmuO2jSvET7KfrJ1PpX
 eF8bjROhaAGVgMKisiJUTk7+83UlHG0LXvw0/7xsGBiXBAJb5HZr8T7vJ89VUW5g9FJq+VPEI
 0TetEghy46TpvhSUetEURm25Jcdl2mzQI7XKFGlccGkPWX0dheKgsh/M5SrRVUbgBeJSBHC7g
 pSbdWhFu9az2mDszgIS1JUsrKlVGcvKdMUN2KBqxKjWXnZ3YdSbGFFaGPD+zTn194ug5FfLvl
 lPlTIMyg8B2TcpG+4sjb71vEkBSC0Itb/Um+0zjirg5U4ffInreqWcpHc8rKkaeCt5RdcDCOH
 VQ0MGsIkg186SQF7/bxdYi51N8eOFbXpOUvTQJUSEUn7tGdTRwwoqXrxFPoX4hhEXW2lOCf8L
 uFL4NVN+dt3lMRAVN
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 Apr 2020 14:02:55 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 24 Apr 2020 14:02:52 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [RFC PATCH 00/25] cocci: Improve C parsing of attributes
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

PiBUaGlzIHBhdGNoIHNlcmllcyBhaW1zIHRvIGltcHJvdmUgcGFyc2luZyBvZiBhdHRyaWJ1dGVz
IGluIEMgYnkKPiBDb2NjaW5lbGxlJ3MgQyBwYXJzZXIuCgpIb3cgZG8geW91IHRoaW5rIGFib3V0
IHRvIHVzZSB0aGUgd29yZGluZyDigJxpbiBDIHNvdXJjZSBjb2RlIGJ54oCdPwoKCj4gVGhlc2Ug
cGFyc2luZyBlcnJvcnMgd2VyZSBkaXNjb3ZlcmVkIGJ5IHJ1bm5pbmcgYSBidWlsZCBvZiBDb2Nj
aW5lbGxlJ3MKCldvdWxkIHlvdSBsaWtlIHRvIG9taXQgdGhlIHdvcmQg4oCcVGhlc2XigJ0/CgoK
PiBDb2NjaW5lbGxlIGN1cnJlbnRseSBtYW5hZ2VzIGF0dHJpYnV0ZXMgc2ltaWxhciB0byBjb21t
ZW50cywKCldpbGwgdGhpcyBhc3BlY3QgdHJpZ2dlciBmdXJ0aGVyIHNvZnR3YXJlIGRldmVsb3Bt
ZW50IGNvbnNpZGVyYXRpb25zPwoKCj4gc28gdG8gZXhwbGljaXR5IHN0YXRlIHdoYXQgdGhlIGF0
dHJpYnV0ZXMgYXJlIHRvIHRoZSBDIHBhcnNlciwKPiBhIE1BQ1JPQU5OT1RBVElPTiBoaW50IHdh
cyB1c2VkIGluIENvY2NpbmVsbGUncyBzdGFuZGFyZC5oIGZpbGUuCgpJIGZpbmQgc3VjaCBpbmZv
cm1hdGlvbiBzdXNwaWNpb3VzIGF0IGZpcnN0IGdsYW5jZS4KQWRkaXRpb25hbCBiYWNrZ3JvdW5k
IGluZm9ybWF0aW9uIGZyb20gYW4gdXBkYXRlIHN0ZXAgbGlrZQrigJxbUkZDIFBBVENIIDEyLzI1
XSBwYXJzaW5nX2M6IGNwcF90b2tlbl9jOiBJbnRyb2R1Y2UgTUFDUk9BTk5PVEFUSU9OIGhpbnTi
gJ0KbWlnaHQgbWFrZSB0aGUgcHJvcG9zZWQgZGF0YSBwcm9jZXNzaW5nIGFwcHJvYWNoIG1vcmUg
cmVhc29uYWJsZS4KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvY29jY2kvMjAyMDA0MjQwOTE4MDEu
MTM4NzEtMTMtamFza2FyYW5zaW5naDc2NTQzMjFAZ21haWwuY29tLwpodHRwczovL3N5c3RlbWUu
bGlwNi5mci9waXBlcm1haWwvY29jY2kvMjAyMC1BcHJpbC8wMDcyMTcuaHRtbAoKCj4gU2VwYXJh
dGUgcGF0Y2hlcyB3aWxsIGJlIHNlbnQgZm9yIHRoZSBhYm92ZS4KCkkgYW0gY3VyaW91cyBob3cg
dGhlIHNvZnR3YXJlIGV2b2x1dGlvbiB3aWxsIGJlIGNvbnRpbnVlZCBoZXJlLgoKUmVnYXJkcywK
TWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNv
Y2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxp
cDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
