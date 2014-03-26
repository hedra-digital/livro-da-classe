<?php

/* error.twig */
class __TwigTemplate_c8f4617f1380d2b32d00683446d5492a extends Twig_Template
{
    public function __construct(Twig_Environment $env)
    {
        parent::__construct($env);

        $this->parent = $this->env->loadTemplate("layout.twig");

        $this->blocks = array(
            'title' => array($this, 'block_title'),
            'body' => array($this, 'block_body'),
        );
    }

    protected function doGetParent(array $context)
    {
        return "layout.twig";
    }

    protected function doDisplay(array $context, array $blocks = array())
    {
        $this->parent->display($context, array_merge($this->blocks, $blocks));
    }

    // line 2
    public function block_title($context, array $blocks = array())
    {
        echo "GitList";
    }

    // line 4
    public function block_body($context, array $blocks = array())
    {
        // line 5
        $this->env->loadTemplate("navigation.twig")->display($context);
        // line 6
        echo "
<div class=\"container\">

    <div class=\"alert alert-error\">
        <strong>Oops!</strong> ";
        // line 10
        if (isset($context["message"])) { $_message_ = $context["message"]; } else { $_message_ = null; }
        echo twig_escape_filter($this->env, $_message_, "html", null, true);
        echo "
    </div>

    <hr />

    ";
        // line 15
        $this->env->loadTemplate("footer.twig")->display($context);
        // line 16
        echo "</div>
";
    }

    public function getTemplateName()
    {
        return "error.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  57 => 16,  55 => 15,  46 => 10,  40 => 6,  38 => 5,  35 => 4,  29 => 2,);
    }
}
