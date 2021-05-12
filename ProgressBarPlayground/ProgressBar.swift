//
//  ProgressBar.swift
//  ProgressBarPlayground
//
//  Created by Daichi Hayashi on 2021/05/12.
//

import UIKit

class ProgressBar: UIView {

    private var progressBar: UIProgressView = UIProgressView()

    private let animationDuration: TimeInterval = 0.5

    override func layoutSubviews() {
        super.layoutSubviews()

        setup()
    }

    private func setup() {
        addSubview(progressBar)
        progressBar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: topAnchor),
            progressBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            progressBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])

        progressBar.progress = 0

        progressBar.layer.cornerRadius = frame.height / 2
        progressBar.clipsToBounds = true

        // 中で満ちているゲージも rounded させたい場合は以下を指定する
        progressBar.layer.sublayers![1].cornerRadius = frame.height / 2
        progressBar.subviews[1].clipsToBounds = true
    }

    func reset() {
        progressBar.setProgress(0, animated: false)
    }

    func setProgress(_ progress: Float,
                     with options: UIView.AnimationOptions,
                     damping: CGFloat = 1,
                     springVelocity: CGFloat = 0.0) {

        let restrictedProgress: Float = min(1.0, max(0.0, progress))

        // options 引数を指定したい場合、usingSpringWithDamping と initialSpringVelocity
        // を指定すると options の内容が反映されないので場合分けしている。

        if damping < 1.0 {
            UIView.animate(withDuration: animationDuration,
                           delay: 0,
                           usingSpringWithDamping: damping,
                           initialSpringVelocity: springVelocity) {
                self.progressBar.setProgress(restrictedProgress, animated: true)
            }

        } else {
            UIView.animate(withDuration: animationDuration,
                           delay: 0,
                           options: options) {
                self.progressBar.setProgress(restrictedProgress, animated: true)
            }
        }
    }
}
