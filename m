From: willy@infradead.org (Matthew Wilcox)
Date: Mon, 30 Apr 2018 15:41:33 -0700
Subject: [Cocci] [PATCH 2/2] mm: Add kvmalloc_ab_c and kvzalloc_struct
In-Reply-To: <4ad99a55-9c93-5ea1-5954-3cb6e5ba7df9@rasmusvillemoes.dk>
References: <20180308025812.GA9082@bombadil.infradead.org>
 <alpine.DEB.2.20.1803080722300.3754@hadrien>
 <20180308230512.GD29073@bombadil.infradead.org>
 <alpine.DEB.2.20.1803131818550.3117@hadrien>
 <20180313183220.GA21538@bombadil.infradead.org>
 <CAGXu5jKLaY2vzeFNaEhZOXbMgDXp4nF4=BnGCFfHFRwL6LXNHA@mail.gmail.com>
 <20180429203023.GA11891@bombadil.infradead.org>
 <CAGXu5j+N9tt4rxaUMxoZnE-ziqU_yu-jkt-cBZ=R8wmYq6XBTg@mail.gmail.com>
 <20180430201607.GA7041@bombadil.infradead.org>
 <4ad99a55-9c93-5ea1-5954-3cb6e5ba7df9@rasmusvillemoes.dk>
Message-ID: <20180430224133.GA7076@bombadil.infradead.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Apr 30, 2018 at 11:29:04PM +0200, Rasmus Villemoes wrote:
> On 2018-04-30 22:16, Matthew Wilcox wrote:
> > On Mon, Apr 30, 2018 at 12:02:14PM -0700, Kees Cook wrote:
> >> (I just wish C had a sensible way to catch overflow...)
> > 
> > Every CPU I ever worked with had an "overflow" bit ... do we have a
> > friend on the C standards ctte who might figure out a way to let us
> > write code that checks it?
> 
> gcc 5.1+ (I think) have the __builtin_OP_overflow checks that should
> generate reasonable code. Too bad there's no completely generic
> check_all_ops_in_this_expression(a+b*c+d/e, or_jump_here). Though it's
> hard to define what they should be checked against - probably would
> require all subexpressions (including the variables themselves) to have
> the same type.

Nevertheless these generate much better code than our current safeguards!

extern void *malloc(unsigned long);

#define ULONG_MAX (~0UL)
#define SZ	8UL

void *a(unsigned long a)
{
	if ((ULONG_MAX / SZ) > a)
		return 0;
	return malloc(a * SZ);
}

void *b(unsigned long a)
{
	unsigned long c;
	if (__builtin_mul_overflow(a, SZ, &c))
		return 0;
	return malloc(c);
}

(a lot of code uses a constant '8' as sizeof(void *)).  Here's the
difference with gcc 7.3:

   0:   48 b8 fe ff ff ff ff    movabs $0x1ffffffffffffffe,%rax
   7:   ff ff 1f 
   a:   48 39 c7                cmp    %rax,%rdi
   d:   76 09                   jbe    18 <a+0x18>
   f:   48 c1 e7 03             shl    $0x3,%rdi
  13:   e9 00 00 00 00          jmpq   18 <a+0x18>
                        14: R_X86_64_PLT32      malloc-0x4
  18:   31 c0                   xor    %eax,%eax
  1a:   c3                      retq   

vs

  20:   48 89 f8                mov    %rdi,%rax
  23:   ba 08 00 00 00          mov    $0x8,%edx
  28:   48 f7 e2                mul    %rdx
  2b:   48 89 c7                mov    %rax,%rdi
  2e:   70 05                   jo     35 <b+0x15>
  30:   e9 00 00 00 00          jmpq   35 <b+0x15>
                        31: R_X86_64_PLT32      malloc-0x4
  35:   31 c0                   xor    %eax,%eax
  37:   c3                      retq   

We've traded a shl for a mul (because shl doesn't set Overflow, only
Carry, and that's only bit 65, not an OR of bits 35-n), but we lose the
movabs and cmp.  I'd rather run the second code fragment than the first.
