class Traveler {

  int bot, lastBot;
  int target;
  

  Traveler(int bot_) {
    bot = bot_;
    lastBot = bot;
    target = floor(random(sys.nodes.size()));
  }

  void update() {  
    if (target != -1) {
      lastBot = bot;
      Node n1 = (Node)sys.nodes.get(bot);
      Node n2 = (Node)sys.nodes.get(target);
      if (bot != target && n2.walkable) {
        ArrayList <Node> path = new ArrayList();
        println("antes"); 

        path = sys.bfs(n1, n2);
        println("despues");
        // a path starts at finish and ends at start, so the next move would be one away from the end of the path
        if (path.size() > 1) {
          Node n = path.get(path.size()-2);
          bot = sys.nodes.indexOf(n);

          for (Atom atom : atoms) {
            if (atom.node == n) {
              float jitter = 0;
              atom.p.position().add(random(-1, 1)*jitter,random(-1, 1)*jitter, 0); 
            }
          }
        }
      }
      else {
        target = floor(random(sys.nodes.size()));
      }
    }
  }

  void draw() {
    Node n1 = (Node)sys.nodes.get(bot);
    Node n2 = (Node)sys.nodes.get(lastBot);
    Atom a1 = null;
    for (Atom atom : atoms) {
      if (atom.node == n1) {
        a1 = atom;
      }
    }
    ellipse(a1.p.position().x(), a1.p.position().y(), 10, 10);
    Atom a2 = null;
    for (Atom atom : atoms) {
      if (atom.node == n2) {
        a2 = atom;
      }
    }
    stroke(255, 0, 0);
    line(a1.p.position().x(), a1.p.position().y(), a2.p.position().x(), a2.p.position().y());
  }
}

