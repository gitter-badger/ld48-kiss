package entities;

import flash.display.Shape;
import flash.display.Graphics;
import flash.geom.Point;
import flash.geom.Rectangle;
import scenes.ALevel;
import entities.AEntity;
import entities.Ammo;
import entities.Health;
import SoundBank;

class Wall extends AEntity
{
    static inline public var WIDTH : Int = 40;
    static inline public var HEIGHT : Int = 40;
    
    public var health(default, default) : Int;
    public var angle(default, default) : Float;
    private var _figures : Shape;
    
    public function new(position : Point)
    {
        super(new Rectangle(position.x - Wall.WIDTH / 2, position.y - Wall.HEIGHT / 2, Wall.WIDTH, Wall.HEIGHT));
        this._figures = new Shape();
        addChild(this._figures);
        health = 3;
        angle = 0;
    }
    
    public function takeHit(scene : ALevel) : Void
    {
        --health;
        SoundBank.instance.wall.play();
        if (0 >= health) {
            scene.director.score += 1;
            scene.removeEntity(this);
            scene.director.loot(scene, position);
            clean();
        }
    }
    public override function draw(scene : ALevel) : Void
    {
        this._figures.rotation = angle * 180.0 / Math.PI;
        var g : Graphics = this._figures.graphics;
        g.clear();
        if (3 == health) {
            g.beginFill(0x909090);
        }
        else if (2 == health) {
            g.beginFill(0x707070);
        }
        else if (1 == health) {
            g.beginFill(0x505050);
        }
        g.drawRect(-20, -20, 40, 40);
    }
    
    public override function clean() : Void
    {
        super.clean();
        removeChild(this._figures);
    }
}