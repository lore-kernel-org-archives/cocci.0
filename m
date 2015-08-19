From: mmarek@suse.cz (Michal Marek)
Date: Wed, 19 Aug 2015 17:24:10 +0200
Subject: [Cocci] [PATCH] coccinelle: api: extend spatch for dropping
 unnecessary owner
In-Reply-To: <1436503986-21487-1-git-send-email-k.kozlowski@samsung.com>
References: <1436503986-21487-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <55D49F9A.4030802@suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 2015-07-10 06:53, Krzysztof Kozlowski wrote:
> i2c_add_driver (through i2c_register_driver) sets the owner field so we
> can drop it also from i2c drivers, just like from platform drivers.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Applied to kbuild.git#misc.

Michal
