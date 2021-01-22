//
//  File.swift
//  
//
//  Created by Jakub Łaszczewski on 22/01/2021.
//

import SwiftUI

public struct EdgeBorder: Shape {
  
  private var edges: [Edge]
  private var radius: CGFloat
  
  public init(
    edges: [Edge],
    radius: CGFloat = 4
  ) {
    self.edges = edges
    self.radius = radius
  }
  
  public func path(in rect: CGRect) -> Path {
    let (brs, brc, bls, blc, tls, tlc, trs, trc) = preparePoints(
      for: rect,
      with: edges,
      radius: radius)
    
    return preparePathWithPoints(
      brs: brs,
      brc: brc,
      bls: bls,
      blc: blc,
      tls: tls,
      tlc: tlc,
      trs: trs,
      trc: trc)
  }
}

public extension EdgeBorder {
  
  func preparePoints(
    for rect: CGRect,
    with edges: [Edge],
    radius: CGFloat
  ) -> (
    CGPoint,
    CGPoint?,
    CGPoint,
    CGPoint?,
    CGPoint,
    CGPoint?,
    CGPoint,
    CGPoint?
  ) {
    let brs = CGPoint(
      x: rect.maxX,
      y: edges.contains(.trailing) && edges.contains(.bottom)
        ? rect.maxY - radius
        : rect.maxY)
    let brc = edges.contains(.trailing) && edges.contains(.bottom)
      ? CGPoint(x: rect.maxX - radius, y: rect.maxY - radius)
      : nil
    let bls = CGPoint(
      x: edges.contains(.bottom) && edges.contains(.leading)
        ? rect.minX + radius
        : rect.minX,
      y: rect.maxY)
    let blc = edges.contains(.bottom) && edges.contains(.leading)
      ? CGPoint(x: rect.minX + radius, y: rect.maxY - radius)
      : nil
    let tls = CGPoint(
      x: rect.minX,
      y: edges.contains(.leading) && edges.contains(.top)
        ? rect.minY + radius
        : rect.minY)
    let tlc = edges.contains(.leading) && edges.contains(.top)
      ? CGPoint(x: rect.minX + radius, y: rect.minY + radius)
      : nil
    let trs = CGPoint(
      x: edges.contains(.top) && edges.contains(.trailing)
        ? rect.maxX - radius
        : rect.maxX,
      y: rect.minY)
    let trc = edges.contains(.top) && edges.contains(.trailing)
      ? CGPoint(x: rect.maxX - radius, y: rect.minY + radius)
      : nil
    
    return (brs, brc, bls, blc, tls, tlc, trs, trc)
  }
  
  func preparePathWithPoints(
    brs: CGPoint,
    brc: CGPoint?,
    bls: CGPoint,
    blc: CGPoint?,
    tls: CGPoint,
    tlc: CGPoint?,
    trs: CGPoint,
    trc: CGPoint?
  ) -> Path {
    var path = Path()
    
    if edges.contains(.bottom) {
      path.move(to: brs)
    }
    
    if let brc = brc {
      path.addRelativeArc(
        center: brc,
        radius: radius,
        startAngle: Angle.degrees(0),
        delta: Angle.degrees(90))
    }
    
    if edges.contains(.bottom) {
      path.addLine(to: bls)
    } else if edges.contains(.leading) {
      path.move(to: bls)
    }
    
    if let blc = blc {
      path.addRelativeArc(
        center: blc,
        radius: radius,
        startAngle: Angle.degrees(90),
        delta: Angle.degrees(90))
    }
    
    if edges.contains(.leading) {
      path.addLine(to: tls)
    } else if edges.contains(.top) {
      path.move(to: tls)
    }
    
    if let tlc = tlc {
      path.addRelativeArc(
        center: tlc,
        radius: radius,
        startAngle: Angle.degrees(180),
        delta: Angle.degrees(90))
    }
    
    if edges.contains(.top) {
      path.addLine(to: trs)
    } else if edges.contains(.trailing) {
      path.move(to: trs)
    }
    
    if let trc = trc {
      path.addRelativeArc(
        center: trc,
        radius: radius,
        startAngle: Angle.degrees(270),
        delta: Angle.degrees(90))
    }
    
    if edges.contains(.trailing) {
      path.addLine(to: brs)
    }
    
    return path
  }
}
