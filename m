Return-Path: <SRS0=nFVp=U2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B060FC48BD6
	for <cocci@archiver.kernel.org>; Thu, 27 Jun 2019 15:01:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29BA02086D
	for <cocci@archiver.kernel.org>; Thu, 27 Jun 2019 15:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="LFZ+79Do"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29BA02086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5RF1CG7005709;
	Thu, 27 Jun 2019 17:01:12 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 088DE7782;
	Thu, 27 Jun 2019 17:01:12 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8944B7772
 for <cocci@systeme.lip6.fr>; Thu, 27 Jun 2019 17:01:10 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5RF19qU004774;
 Thu, 27 Jun 2019 17:01:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1561647668;
 bh=4wk8isruUtgsI1/XSFUcuqMnzZ9zxxeQ/OX12f1xALY=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=LFZ+79DocfD8sQ9OIAm2Az+ExIuI6kJwV0sYhq0k8AqwZH+AFnRawB2DOEAcLT+tV
 jN29qDEVQY70atyzpIsYpgVizii6a37/xw2DjPMcrPcaWC9tkN6nPSmiTNcL1ThQdx
 psAPYKBw5bHOBTinoqcLM/p8Iv3YaTiiinl2cW/E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.74.178]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MYeuk-1i30a62erC-00VT3o; Thu, 27
 Jun 2019 17:01:08 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <708207db-69d7-8962-e507-cd705142d0c4@web.de>
 <f79ae892-a674-5f69-1d25-88594a89ebff@web.de>
 <alpine.DEB.2.21.1906271332240.2627@hadrien>
 <f84bb58a-916b-0d6b-64fd-7805bd8db827@web.de>
 <alpine.DEB.2.21.1906271427250.2627@hadrien>
 <ddc47c39-1977-fa90-2f93-72acb2303d6c@web.de>
 <alpine.DEB.2.21.1906271653410.2627@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <0d2aee49-16e4-0263-d37b-f41821eae17c@web.de>
Date: Thu, 27 Jun 2019 17:01:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906271653410.2627@hadrien>
Content-Type: multipart/mixed; boundary="------------AE220EF00FDDB41015F20A11"
Content-Language: en-GB
X-Provags-ID: V03:K1:qROcugpLpLjLuqE7l183dxTwLpetEBJar6hy/efMhx1U5wTIh9h
 0XVr+hHAleJWDFbexnPFRHJ3/51Ava7z3hnHoN1oBNEy3YcL9JKkAPLDW5LV65/RI6yxCW3
 dyM/byYsEKx12kb8xAlYb472CVtso6cfnqHHfzvBO2IqYbSVISEWKk/YegE0qQleLus9Xhk
 TW1UGr07+k2jximqvhzBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VlBHIfo39hM=:v72GELepIrSposVYd7PILn
 R2NTcHmBZ1gMFcpXxzjUM6yeXPK6aHZ0N2o7zCzhWSHNzr5sCQKS5U6iegjOGatrOdNGsQogI
 CbQP0IfY6h5VR6rgj5SzkKlKZIIyHd5Eavq2qYH2CWCBY9Tu86dLHAxIveL1VzmtBPGXBd6PD
 hhM6ofEfqWJID1zbBkPIkN21xRO3A2qBiJ4xpTKyEzVpKhvMrQL93Fj1r/szsd7WvV4iwYAHT
 gLJRNqc77q0b7tMSdrhpKBQh/PtYY/9BN1qGh3DygZmx60U1MW9tpF08rpfQNu+Ml3PO6ilzA
 DmnzfDr86Y9gCZrQb3mZftETIeRnTs5uhH96whHqYgseTEFciXe0dXX26NCj9U7II2LYhUCNr
 6HJMzhElnqufrMI8eftzyxHIeQzMI2EPExYuVB//PlORvz5XGZI38AEqlXZzDl5Fp2y6voRQw
 IqjxxoOkKSWXIsY8AnL7neEufBUP/X66TrVcTQ+Ee1kN6Cjk956sxxK8d/WF/jFxKqHHzv6bS
 AWBcdSkbGOFuW4lvTW4ordlrjgqJCLLCUuZh+sIS9JC3RG3VjeXgf7jFzYAeNcnFiEPIp8jyY
 G/ClziqIjpsqRr6gXSZt1+vtIRr4g/vNe8spPTfCQMCDdxBAsdU2MnAHrfPN+QyGu32Llual4
 2uh3S9d0DYBAq14qn3hjeecexGmJZf8HQWjhaAs9q11g4aE6ziBxZU/EEoWUipr3jhlcBS+5e
 2WfoyhyTONmOIMSHBELIGF3opiiXFbcDmB/BaXWuMp+SL/phntVuv2a3qpci/a2l/TYvMzKCT
 A6pkqdBlP6GQgqUfyxDZhTRuCxvGbki+uSSGIC+l6bZC5E7kSUmnMUbD3yYZF/ScvS06hcp0Q
 wARuVAYMRSAahkB5qe1MiUPXlyxJIS+B5yRtTbRhb0f4Iy3e/SDECWM+h8Vbc0xzC4j14OFs8
 xlU59R9xB0CcEpARbAtvX8eSpdFFakA+flENcL5KwHqcGJephs6dRsp1YtzeAO4we85Ypeusp
 WS/CBUyaC6ruDKSUoa/sF7aTcm1+AkwiPvycs4JGOxpeClgnNU4oPYv7uWMy8/hPPszEbkOhc
 K4s5uiwlmtvAyk=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 27 Jun 2019 17:01:12 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 27 Jun 2019 17:01:09 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Moving exception handling code to the end of a function
 implementation with SmPL?
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
--------------AE220EF00FDDB41015F20A11
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>> Where did the Coccinelle software get the impression that anything
>> would be added too often at the end of such a function implementation?
>
> Without the semantic patch and the C source code,

You have access to data from both files already.


> I can't answer the question.

Is it more convenient to check test results for attachments again?

Regards,
Markus

--------------AE220EF00FDDB41015F20A11
Content-Type: text/plain; charset=UTF-8;
 name="move_error_code_assignment_to_function_end1.cocci"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="move_error_code_assignment_to_function_end1.cocci"

QHJlcGxhY2VtZW50QApleHByZXNzaW9uIGluZm8sIHJlc3VsdDsKaWRlbnRpZmllciB0YXJn
ZXQsIHdvcms7CnR5cGUgdCAhPSB2b2lkOwpAQAogdCB3b3JrKC4uLikKIHsKIDwrLi4uCiBp
ZiAoLi4uKQooCi17Ci1yZXN1bHQgPSBpbmZvOwogZ290bwotICAgICB0YXJnZXQKKyAgICAg
ZV9ub2RldgogOwotfQp8CiB7CiAuLi4KLXJlc3VsdCA9IGluZm87CiBnb3RvCi0gICAgIHRh
cmdldAorICAgICBlX25vZGV2CiA7CiB9CikKIC4uLis+CiB0YXJnZXQ6CiAuLi4KIHJldHVy
biByZXN1bHQ7CitlX25vZGV2OgorcmVzdWx0ID0gaW5mbzsKK2dvdG8gdGFyZ2V0OwogfQo=
--------------AE220EF00FDDB41015F20A11
Content-Type: text/x-csrc;
 name="megaraid_sas-excerpt1.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="megaraid_sas-excerpt1.c"

// SPDX-License-Identifier: GPL-2.0-or-later

// Deleted part

static int megasas_mgmt_ioctl_fw(struct file *file, unsigned long arg)
{
	struct megasas_iocpacket __user *user_ioc =3D
	    (struct megasas_iocpacket __user *)arg;
	struct megasas_iocpacket *ioc;
	struct megasas_instance *instance;
	int error;

	ioc =3D memdup_user(user_ioc, sizeof(*ioc));
	if (IS_ERR(ioc))
		return PTR_ERR(ioc);

	instance =3D megasas_lookup_instance(ioc->host_no);
	if (!instance) {
		error =3D -ENODEV;
		goto out_kfree_ioc;
	}

	/* Block ioctls in VF mode */
	if (instance->requestorId && !allow_vf_ioctls) {
		error =3D -ENODEV;
		goto out_kfree_ioc;
	}

	if (atomic_read(&instance->adprecovery) =3D=3D MEGASAS_HW_CRITICAL_ERROR=
) {
		dev_err(&instance->pdev->dev, "Controller in crit error\n");
		error =3D -ENODEV;
		goto out_kfree_ioc;
	}

	if (instance->unload =3D=3D 1) {
		error =3D -ENODEV;
		goto out_kfree_ioc;
	}

	if (down_interruptible(&instance->ioctl_sem)) {
		error =3D -ERESTARTSYS;
		goto out_kfree_ioc;
	}

	if  (megasas_wait_for_adapter_operational(instance)) {
		error =3D -ENODEV;
		goto out_up;
	}

	error =3D megasas_mgmt_fw_ioctl(instance, user_ioc, ioc);
out_up:
	up(&instance->ioctl_sem);

out_kfree_ioc:
	kfree(ioc);
	return error;
}

--------------AE220EF00FDDB41015F20A11
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--------------AE220EF00FDDB41015F20A11--
