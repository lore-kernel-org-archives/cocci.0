From: kumar.gala@linaro.org (Kumar Gala)
Date: Thu, 26 Jan 2017 08:32:04 -0600
Subject: [Cocci] Help with include coccinelle & include paths?
Message-ID: <BBB6D7E1-F6F1-4FE4-80D6-8BD4C6F36026@linaro.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I?m looking at using coccinelle with the Zephyr project:

https://www.zephyrproject.org/
https://gerrit.zephyrproject.org/r/gitweb?p=zephyr.git;a=summary

We utilize Kconfig & Kbuild from linux kernel.  However, I?m trying to figure out how to deal with our includes.  I?ve played around with the various options to spatch, but either get a StackOverflow --recursive-includes or not getting all cases figured out since typedef & #defines aren?t getting parsed fully.

Wondering what are best practices or things to try here.  I?m also not clear on what the messages one gets when enable some of the debug options like --verbose-parsing --type-error-msg.

- k
