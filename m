Return-Path: <SRS0=FZn7=YS=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973F7CA9EA0
	for <cocci@archiver.kernel.org>; Fri, 25 Oct 2019 07:43:08 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C078120867
	for <cocci@archiver.kernel.org>; Fri, 25 Oct 2019 07:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="jCbCb9/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C078120867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9P7go0t010591;
	Fri, 25 Oct 2019 09:42:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C9ED477BE;
	Fri, 25 Oct 2019 09:42:50 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E51BE7415
 for <cocci@systeme.lip6.fr>; Fri, 25 Oct 2019 09:42:48 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9P7glc4002558;
 Fri, 25 Oct 2019 09:42:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571989347;
 bh=GDofDCMX8AaPDbkxKBCxc0BlDUkpTze2X8EjoPIi0TI=;
 h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
 b=jCbCb9/jwF/SBAggmn/KQ894XLIH8aQiXS3w1N1HhZpiNSVcR9zekSkXIFnsHYXYA
 fGvRCYqzYgN9JM9GM5AqySAzs5HhJAwU8qOIaqAOzRWeKwNcbpLTABEDTXobjB2fWi
 YBHnfzvdbG0w+9+JdCALXopC3tsicXg8mIduL874=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.4.210]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lr2Dz-1hjuWe2Kkl-00efHN; Fri, 25
 Oct 2019 09:42:27 +0200
To: Zhong Shiqi <zhong.shiqi@zte.com.cn>, cocci@systeme.lip6.fr
References: <1571966374-42566-1-git-send-email-zhong.shiqi@zte.com.cn>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <14f7a50d-63f5-343f-70e8-6b42ab5baa4c@web.de>
Date: Fri, 25 Oct 2019 09:42:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <1571966374-42566-1-git-send-email-zhong.shiqi@zte.com.cn>
Content-Language: en-US
X-Provags-ID: V03:K1:sVUG2yY+qFXJRrPp16ghLmbqDdLvdUi5iy02aESUYFE1h1BJ783
 p8wFqe6Aen+JhoclMUbfEcuOyp7Ai/gRHe0OQ11FGm0lzwT7XTNr7xeiNCtoSjMZ+UEU701
 vLhYbezZx+wKpUsoByUYf7qHhXz33gmpkL+nTmwYUtBNAKOovXG+Q0B939jf1vAJNNvgVpQ
 WMpRQ6GkBHvzzd+zgq7Zg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+++V7Rp9Nr4=:hb3DaqPVq6FwyGLyg3XAiz
 9vc1lWzvZ6uopGtcklFIZoyZVe/sWsYwMPV1wMJt119Zy+KsUVeHAYJV+kq3sBM28k2DqGFrz
 2/fv3mNq82dJj2o6vCjpbRopFB0GOlQnuKuFL7XQE9jp1qGBxmdVHgyVh4tWU6b9eWaPqyZOr
 slhZolru2f4K+cTdpY0YMkcbdqhxDgldSdUAXtx69GxLYl3Foz5ZbQzbgWCK6J6qtR8cMypqF
 Np+D5L0KqawYT3j+I7oCEiyor6e6ACddoQN/ljRdKVTNmv4Aj2itd7G7pQGNcWxoYCmey7C6/
 sUPBOL2CaIVocUC4WeA8mCydE7WnjNvTSSMEa5tYC/vqmZtAfGROEDsKTt18+Pi/k5VjVibq2
 s3eSBU9s5JMOTGQMwcoUQN15xlQJp6lCSUrXl4LVmIoax4g5vrH2Q4/JpuCtSyqhWIcBJ0C7p
 lpS3Hi22roVZUCa+St3hCZw/UKm8ICXKpKKXt1jKeWJRbA0FNdwjAebNEAYlarGhaMTFVqagT
 MLmRAX+srT0AnUGriBLjmu0Ms3bSGkdkDqY9CLIbRIjjpsN/PvQgqXlpGiV+fayG1Bf1nDAbU
 h/RcS1g6A5pnD4j3+dTstwK0/uRfOZQybU6yJJhhm4RBDi6Rmhpa3EzHwKpgW0t5JHQgortIh
 ntS/uMp+ySo8byzb8DLmExInJARU0/957HL7Z4C6E9kwRwdaPeNZ3oFYC/Uw5BzYe0QdpVq1A
 vKWLVcZqOb2r5in7kO6Y4NEpf6p4/NcFS37Wz3K1gLM75DYwC53OSxvbcZGQPBgC2150MnyM2
 sonnTJ1imCxzpHZKS3GUeIvFp4IctdkJKjZr0xpAvwmmSu/Z36DGjzQ3a4c/mwGxDDg3Pt/bX
 4iNqm3ljnoeCfoJnd4SL/urFl5Jqj4aS9qlezAohe9VXLw++SPTWJcr9uA2RYRwwmrgz8CeZD
 W4sq9SamatEjnF3qyCeCkiX/qJLF9ZKR/ieGZVNt8iR5xmQ4wNGo0iZfJn5IcUHA6vSGjcAlJ
 QTsY5LcplkWtx/S1YPGU0HG/cUVF6PfJIckqobJYFyiRxg7hxdpdJvfHDTSi/pkh18sq7afTr
 GxMEK+RqNkMmAuE8Bt1rb80G17QqNYMyg8GlRM5F2KGUraG32qvdyPg6tGrSPsgHE+5unT9nU
 iQjrRNkEFwzbVDkGBoZKxOxx0VYJ5Q1EpvObpZJJI+n7Anq4WK1IU/VxL/m8wCE+I/F/WEAd7
 waesq+Ue7EtiumLvhsRy3BUySqBgLPlQCuGE/3f/NhBoBSi3HcLrZAb1veJk=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 25 Oct 2019 09:42:51 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 25 Oct 2019 09:42:47 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xue Zhihong <xue.zhihong@zte.com.cn>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>
Subject: Re: [Cocci] [PATCH v3] coccicheck: Support search for SmPL scripts
 within selected directory hierarchy
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

PiBBbGxvdyBkZWZpbmluZyBDT0NDSSBhcyBhIGRpcmVjdG9yeSB0byBzZWFyY2ggU21QTCBzY3Jp
cHRzLiBTdGFydCBhCj4gY29ycmVzcG9uZGluZyBmaWxlIGRldGVybWluYXRpb24gaWYgdGhlIGVu
dmlyb25tZW50IHZhcmlhYmxlIOKAnENPQ0NJ4oCdCj4gY29udGFpbnMgYW4gYWNjZXB0YWJsZSBw
YXRoLgoKQ2FuIGFub3RoZXIgd29yZGluZyBmaW5lLXR1bmluZyBtYXR0ZXIgZm9yIHN1Y2ggYSBj
aGFuZ2UgZGVzY3JpcHRpb24/CgogICogQWxsb3cgZGVmaW5pbmcgdGhlIGVudmlyb25tZW50IHZh
cmlhYmxlIOKAnENPQ0NJ4oCdIGFzIGEgZGlyZWN0b3J5CiAgICB0byBzZWFyY2ggU21QTCBzY3Jp
cHRzLgoKICAqIFN0YXJ0IGEgY29ycmVzcG9uZGluZyBmaWxlIGRldGVybWluYXRpb24gaWYgaXQg
Y29udGFpbnMgYW4gYWNjZXB0YWJsZSBwYXRoLgoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApD
b2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0
aW5mby9jb2NjaQo=
