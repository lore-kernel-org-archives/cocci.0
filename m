Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7757C369D7
	for <cocci@archiver.kernel.org>; Wed, 23 Apr 2025 08:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=rUgcReSeERaYjdCHY/S65QNcDRKyKTJVSUifM/SqTHw=;
  b=uZhyQ0ZBkMdCSt2qYirXNlvWOcB09Lfk1sM/kX5plwkb8YCUyvQaJQp8
   2QNf6I6O7OuhjahSjIXNC8FuGaS/fYjJF/kuvRe13EbDpAU4oA3nWsw25
   wioPGy2Ocum82Jj98Vk51F1WBQdYwLAQ+LKn6eGabdyGmg9OO8OdcjhZc
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@lunn.ch
X-IronPort-AV: E=Sophos;i="6.15,233,1739833200"; 
   d="scan'208";a="219056158"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Apr 2025 10:51:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0EE48E0DA6; Wed, 23 Apr 2025 10:51:25 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8CD83E007A
	for <cocci@sympa.inria.fr>; Thu, 17 Apr 2025 19:22:49 +0200 (CEST)
IronPort-SDR: 680138e9_wYqOivS6vZcU0SV/k6sxG/m1rjVo8xyiNmF2sbK6juyRbgu
 FyRBzyfX86SRkBJ0NPuuf5WeJ4kPzkGShZEfsWQ==
X-IPAS-Result: =?us-ascii?q?A0FKAABqOAFohWUKQ5xaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UIEAQELAYJDgVY0BwhIlkkRhCqbVQ8BAwENRAQBAQSFAwKLKwIfBgEEMwYOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQEBQEmFew2CYgGCS?=
 =?us-ascii?q?SyBCwEBAQM6BgEBNwEPCw4EBhkCARJIDgYTgwKCZQOxFoE0gQGCDAEBBtwgg?=
 =?us-ascii?q?WUJgUkBhWyCYwGFbIN9eicbgg2BPAuCeD6FIAOFZIIxgReDL4QjhD+FM4Juj?=
 =?us-ascii?q?SZSexwDWSwBVRMXCwcFgSlDA4EPI04FMB2BeoN0hTaCEYFcAwMiAYMVdxyEb?=
 =?us-ascii?q?YRXLU+DM4IGHUACAQttPTcJCxsGmHaDJoIBAYJ7ljoBsAyCPx+BR4Fkn2oGD?=
 =?us-ascii?q?wQvgUupDC6YUKNWDYVSgX0kgVwzGggwgyJPAxkPjiEZgznGG0QyPAIHCwEBA?=
 =?us-ascii?q?wmPai0FgUsBAQ?=
IronPort-PHdr: A9a23:D/y1WBeg7bRuoahvQFlcoOcJlGM+V9XLVj580XLHo4xHfqnrxZn+J
 kuXvawr0ASTG92DoKge2rqN+4nbGkU+or+580o+OKRWUBEEjchE1ycBO+WiTXPBEfjxciYhF
 95DXlI2t1uyMExSBdqsLwaK+i764jEdAAjwOhRoLerpBIHSk9631+ev8JHPfglEnjWwbL1sI
 BmssQndqsYajZV8Jqs1yRbErGZDdvhLy29vOV+ckBHw69uq8pJk7ypepe8q+dRaUaX9caQ4T
 LhYAyojPmso+sDltgTNQBWW6HcEXWoYjhRHAw7e7BHnRZjxqTf1tvB82CaBI8L7S60/VCm44
 KdqTB/ojzoHNyI8/WrKhMF8kL5XrRS8rBFk3YXafJ+aO+Z/fqPFfNMVW2xBXtpKVydcBo+wd
 pYDA/YdMepdqYT2ulkAogakBQS0Cu3hyiFGi2Hr06M53eQuHh3J0xEiEN8VrHTYsM/4OLsOX
 eyp0qXFyyjIYfNM2Tf67YjFagwsofeRUrJqb8XQx1QkGQXYjlWWr4zuIjSY2f4Ls2eG9epvS
 +yuhnUjqwFspDivwN0ghZXJho8MzF3P6Cp2zpovK9KiVE57fcCrEIFWtyyCKoZ4Td8vTmV2t
 Csm1rELt4K2cSoFxpon2xLRZOCLfouH7B7/VOidPzl1inx5dL+wmhq8/1Stx/P+W8e601tHr
 CxImcTPuHAVzxHf98iKR/pn8kqg2zuDzR3f5v1eLUwpiabXNpgsyaMum5oXrETDBTP2l1vsj
 KGLd0Ul+/an5vz7brjgu5SSLZV7ihvkPaQrgsG/Afo3MgwJX2WD5+S8zKbj8VHjTLVOk/02l
 K/ZvIrGKsQbvqK5AglV3Zg/6xunEjur0NUVkWMGIV9HYh6LkpTlN0vTLPzkEPuzm1Gsny1qx
 /DCML3hGJLNLn3bnbj7e7Zy9lRcxxQ9zN1E45JUF7cBIPTpVkDttNzUFhk5PBeszOb9FNp9z
 p8eWX6IAqKBLq/eqUWI6f43I+mQeI8Vvy7wK/w/6P/gl3A5nVsdcLKo3JsWbXC3Be5mLF+Db
 XrthNcBC2YKsRAkQOzkkl2OSSRTaGqqX6Ig+jE7D5qrApvERo+xnLOB3Ty2HoZWZ2BDElCDC
 23kd4SCW/cWaSKdONVtkjIeVevpd4h08Bi0v0fI2rxoL+fOsnkdvIDL19Vv4eDX0xYo+monI
 d6a1jSkSW1uk3xAYyIw2ugrqEpx0Fqc+axlhfoeHtwFtKABaRszKZOJl78yMNv1QA+UO47RE
 D5OI/2jCDA1FJcqxsMWJlx6EJOkhwzC2CyjB/kUkaaKDdo66PGUxGD/cuB6zXuOz6w9lx8+W
 MIaPGuqnKNg3wzOAYiPmEXK372ye/Ek1TXWvHyG0XLIuUhZVABqVqCQVHYTfEbJhdDk4EWER
 L/9Qa8/PF55wNWZYrBPdsWvjVhCQ6L7P8/CZmuqh2qqLQiQ3evKaJfsfSMW3E0xEWAilAYet
 TaDPAk6XGK6pn7GSSZpHhTpal/t9u93rDW6SFU1xkeEdR8p0b394RMTifGGLpFblrsZpCcsr
 Sl1F1ehzprXDdSHvQ9oYKRbZ5s0/l5G0WvTswE1MIanKuhugVsXcgI/uE2LtV0/A4NMi8U1h
 Hc3ygw0IqLZmFJNejWE3Izhb6XNIzq69xSuZqjKn1DGhY/LpOFRt7Jh8xO65Fj6cyhqu29q2
 NRUzXaGs5DDDQ5IFIn0Tl5y7R9x4bfTfig64YrQk3xqK6i99DHYiLdLTKMozAite9BHPeaKD
 gj3RocTAcS0JfMCn0WvaFQPPKoBvL5xJM6ge/acjeSiOup6kS2OiXlB5sZ20gjfkkg0Av6N1
 JEDzfaC2wKBXDqpl1atvPf8noVcbC0TFG6yocT9LLZYfbY6PYMCCGP0Ztay2s07nZnmHXhR6
 F+kAVoCns6vYxubKVLnj0Vc0kEeoHrvniXdrXQ8mjcltKeA9CjTxeKkfxpPNmNQRWZkhEvhO
 sDt0o5cAhfuNlBvzUP8rU/hj7BWvqF+M3XeTQ9Tci76InsjN8n4/ruObshT6Y855CBeUeCye
 1efGfb2pxoX1T+mHnMLnW1lMW/1/Myh2UUi0TH4Tj47tnfSdMBuyA2K4dXdQaQUxT8aXGxij
 jKRAFGgPt6v9NHSlpHZs+n4WXjyM/8bOSTt046EszO2oGNwBhjq1fm1lsfqDiA+zCn9kdJqH
 3aAvFPnb4/n2r7ve+thclNlG3f49sx8XIp+2NhV5tlYyT0RgZOb+mACmGH4PIBA2K7wW3EKQ
 CYC39/f5AW2kF0mNH+CwJj1E2mM2sY0LcfveXsYg2huiqICQLfR9rFPmjF550a1vR6EK+Yoh
 S8TkLMr+DYTy6QAvA5npsmEKogbBlIQfSnllhDSqsu7sL0SfmGkN765yEt5m9mlSrCEuABVH
 njjKN8uGip578M3N1ypsjW78ob/ZNzZds4erDWKiwyYyexILpR3nfpCiSd8OG37tGEo0KZi0
 EIog8785dDBcj00tKuiSgZVLDj0e98e9lSPxe5Fk8Ca0pruVpRtFzMXXYf5GPKlFDVB/f/jN
 guIDHg9siLCROSZQ1DZsR8g9iqWQPXJfzmNKXIUzMtvXkyYLU1b2kUPWSki24Q+HUaszdDgd
 0Fw4nYQ4ET5o11C0LENVVG3X2HBqQOvcjpxRoKYKU8c5wdO/UrKGciD6OQ1FCESrfjD5ESdb
 3eWYQhFFzRDQkufG1XqJaWj//He6/PAQO6jKf2IarXE+ok8H7+YgJmo1IVh5TOFMM6Ca2JjA
 /MM0U1GRXllGs7dlmZHW2kNminKdcLeuAak93g9sJWk6PqyElGKh8PHG/5IPN5o4RzznaqTK
 7vamnNiMTgBnppGrZcp4KYHxwZUjzxocX+mEeZZ3cYiZKbNnKkRBB5JMkub0eNM8qQ6mAJNa
 5aztw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:TozwUqzE1Mf4/w+8lfreKrPwIb1zdoMgy1knxilNoNJuHPBws/
 re+MjztCWE7Qr5PUtKpTnuAsS9qB/nmaKdpLNhWotKPzOW2ldATrsD0WKK+VSJcREWtNQttp
 uIGJIeNDSfNzdHsfo=
X-Talos-CUID: 9a23:GUruumO3ROf+ke5DAGpl7nIePJweYnDQ63nPBFWDJUI1YejA
X-Talos-MUID: =?us-ascii?q?9a23=3A00sKdgx7FupIZ9kniYhbU8q/gjOaqI6XJmwElac?=
 =?us-ascii?q?3gPWjcipBNW2ws2+dGZByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,219,1739833200"; 
   d="scan'208";a="218372224"
X-MGA-submission: =?us-ascii?q?MDFzNA2eS6jJkSmXMdFfXOxmNNFQXSvDtAT9no?=
 =?us-ascii?q?SPklOsBtNpw2Zs9yX6Tar3Y0qvuz93h9D2YgnkWFnzdkYNbWVTWC2n75?=
 =?us-ascii?q?pl/FF1UE+2CCrBwzNUf1kyzeiJvrmq3Wwyrcfj/TR1sPVRSHEyQ1hA87?=
 =?us-ascii?q?R4M/fQwnumu4DeW3fkF+l77Q=3D=3D?=
Received: from vps0.lunn.ch ([156.67.10.101])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 19:22:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rUgcReSeERaYjdCHY/S65QNcDRKyKTJVSUifM/SqTHw=; b=nNhyFVrHTOlSrXjfJ7WcbfgeDz
	yngeaH3pmyxCVI63fr1I6g9oKwTQbDRIG2W/USafgFWZx+MTv1JOFQGgsDQZP3SUGj4KZ2a0RVDwK
	YTzliV8jwsvbqwGaC7f0x8l7qjpImJw2o4nQTjzI/dzvQwJe6EvZ23voS+PYm4uqjBQk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u5SwX-009oI0-Lw; Thu, 17 Apr 2025 19:22:29 +0200
Date: Thu, 17 Apr 2025 19:22:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marc Zyngier <maz@kernel.org>
Cc: Luo Jie <quic_luoj@quicinc.com>, Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, linux-kernel@vger.kernel.org,
	cocci@inria.fr, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, quic_kkumarcs@quicinc.com,
	quic_linchen@quicinc.com, quic_leiwei@quicinc.com,
	quic_suruchia@quicinc.com, quic_pavir@quicinc.com
Message-ID: <0c97c659-bd28-45e0-8537-d9be2637cb22@lunn.ch>
References: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
 <86sem7jb5t.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86sem7jb5t.wl-maz@kernel.org>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 0/6] Add FIELD_MODIFY() helper
Reply-To: Andrew Lunn <andrew@lunn.ch>
X-Loop: cocci@inria.fr
X-Sequence: 2698
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/0c97c659-bd28-45e0-8537-d9be2637cb22%40lunn.ch>

On Thu, Apr 17, 2025 at 12:10:54PM +0100, Marc Zyngier wrote:
> On Thu, 17 Apr 2025 11:47:07 +0100,
> Luo Jie <quic_luoj@quicinc.com> wrote:
> > 
> > Add the helper FIELD_MODIFY() to the FIELD_XXX family of bitfield
> > macros. It is functionally similar as xxx_replace_bits(), but adds
> > the compile time checking to catch incorrect parameter type errors.
> > 
> > This series also converts the four instances of opencoded FIELD_MODIFY()
> > that are found in the core kernel files, to instead use the new
> > FIELD_MODIFY() macro. This is achieved with Coccinelle, by adding
> > the script field_modify.cocci.
> > 
> > The changes are validated on IPQ9574 SoC which uses ARM64 architecture.
> 
> We already have the *_replace_bits() functions (see
> include/linux/bitfield.h).
> 
> Why do we need extra helpers?

If you look at bitfield.h, the *_replace_bits() seem to be
undocumented internal macro magic, not something you are expected to
use. What you are expected to use in that file is however well
documented. The macro magic also means that cross referencing tools
don't find them.

I think this is a useful additional to bitfield.h.

	Andrew
