<?php

/* commits.twig */
class __TwigTemplate_6a743a96f07d13c1d7e5e24e17fe996c extends Twig_Template
{
    public function __construct(Twig_Environment $env)
    {
        parent::__construct($env);

        $this->parent = $this->env->loadTemplate("layout_page.twig");

        $this->blocks = array(
            'title' => array($this, 'block_title'),
            'content' => array($this, 'block_content'),
        );
    }

    protected function doGetParent(array $context)
    {
        return "layout_page.twig";
    }

    protected function doDisplay(array $context, array $blocks = array())
    {
        // line 3
        $context["page"] = "commits";
        $this->parent->display($context, array_merge($this->blocks, $blocks));
    }

    // line 5
    public function block_title($context, array $blocks = array())
    {
        echo "GitList";
    }

    // line 7
    public function block_content($context, array $blocks = array())
    {
        // line 8
        echo "    ";
        $this->env->loadTemplate("breadcrumb.twig")->display(array_merge($context, array("breadcrumbs" => array(0 => array("dir" => "Commit history", "path" => "")))));
        // line 9
        echo "
    ";
        // line 10
        $this->env->loadTemplate("commits_list.twig")->display($context);
        // line 11
        echo "
    <hr />
";
    }

    public function getTemplateName()
    {
        return "commits.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  48 => 11,  46 => 10,  43 => 9,  40 => 8,  37 => 7,  31 => 5,  26 => 3,);
    }
}
