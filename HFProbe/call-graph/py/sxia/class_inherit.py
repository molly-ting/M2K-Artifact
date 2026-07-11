import ast
import networkx as nx

class ClassInheritanceGraph(ast.NodeVisitor):
    """
    AST NodeVisitor that builds a directed graph representing 
    class inheritance relationships in Python code.
    """

    def __init__(self):
        super().__init__()
        self.graph = nx.DiGraph()
    
    @classmethod
    def get_base_classes(cls, node: ast.ClassDef) -> list[str]:
        """
        Analyze a ClassDef node and return its base classes.
        This method is not used in the current implementation but can be
        useful for extracting class information
        without modifying the graph.
        """
        base_classes = []
        
        for base in node.bases:
            if isinstance(base, ast.Name):
                base_classes.append(base.id)
            elif isinstance(base, ast.Attribute):
                # Handle base classes that are attributes
                full_name = []
                current = base
                while isinstance(current, ast.Attribute):
                    full_name.append(current.attr)
                    current = current.value
                if isinstance(current, ast.Name):
                    full_name.append(current.id)
                base_classes.append(".".join(reversed(full_name)))
            else:
                # Handle other cases as needed
                base_classes.append(ast.unparse(base))
        
        return  base_classes
        
    
    
    def visit_ClassDef(self, node: ast.ClassDef):
        """
        Visit a ClassDef node, extract its name and base classes,
        and add them as edges in the directed graph.
        """
        class_name = node.name
        
        # Ensure the class is in the graph
        if class_name not in self.graph:
            self.graph.add_node(class_name)
        
        base_names = self.get_base_classes(node)
        
        # Add edges from class -> base_class for each base
        for base_class in base_names:
            if base_class not in self.graph:
                self.graph.add_node(base_class)
            self.graph.add_edge(class_name, base_class)
        
        # Continue walking for nested classes, etc.
        self.generic_visit(node)
        
    @classmethod
    def from_code(cls, code: str) -> 'ClassInheritanceGraph':
        """
        Static method to create an ClassInheritanceGraph from code.
        """
        tree = ast.parse(code)
        return cls.from_ast(tree)

    @classmethod
    def from_ast(cls, ast: ast.AST) -> 'ClassInheritanceGraph':
        """
        Static method to create an ClassInheritanceGraph from an AST.
        """
        g = ClassInheritanceGraph()
        g.visit(ast)
        return g
        