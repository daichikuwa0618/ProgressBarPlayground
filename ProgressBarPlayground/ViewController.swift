//
//  ViewController.swift
//  ProgressBarPlayground
//
//  Created by Daichi Hayashi on 2021/05/12.
//

import UIKit

class ViewController: UIViewController {

    private let scrollView = UIScrollView()

    private let progressStackView = UIStackView()
    private let label1 = UILabel()
    private let progressBar1 = ProgressBar()
    private let label2 = UILabel()
    private let progressBar2 = ProgressBar()
    private let label3 = UILabel()
    private let progressBar3 = ProgressBar()
    private let label4 = UILabel()
    private let progressBar4 = ProgressBar()
    private let label5 = UILabel()
    private let progressBar5 = ProgressBar()
    private let label6 = UILabel()
    private let progressBar6 = ProgressBar()
    private let label7 = UILabel()
    private let progressBar7 = ProgressBar()
    private let label8 = UILabel()
    private let progressBar8 = ProgressBar()

    private let controlStackView = UIStackView()
    private let resetButton = UIButton(type: .system)
    private let setButton = UIButton(type: .system)
    private let slider = UISlider()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupScrollView()
        setupStackView()
        setupProgressBars()
        setupLabels()
        setupButtons()
    }

    private func setupScrollView() {
        view.addSubview(scrollView)
        view.addSubview(controlStackView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.alwaysBounceVertical = true

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: controlStackView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }

    private func setupStackView() {
        scrollView.addSubview(progressStackView)

        // progressStackView

        progressStackView.translatesAutoresizingMaskIntoConstraints = false
        progressStackView.alignment = .fill
        progressStackView.spacing = 16
        progressStackView.axis = .vertical

        progressStackView.addArrangedSubview(label1)
        progressStackView.addArrangedSubview(progressBar1)
        progressStackView.addArrangedSubview(label2)
        progressStackView.addArrangedSubview(progressBar2)
        progressStackView.addArrangedSubview(label3)
        progressStackView.addArrangedSubview(progressBar3)
        progressStackView.addArrangedSubview(label4)
        progressStackView.addArrangedSubview(progressBar4)
        progressStackView.addArrangedSubview(label5)
        progressStackView.addArrangedSubview(progressBar5)
        progressStackView.addArrangedSubview(label6)
        progressStackView.addArrangedSubview(progressBar6)
        progressStackView.addArrangedSubview(label7)
        progressStackView.addArrangedSubview(progressBar7)
        progressStackView.addArrangedSubview(label8)
        progressStackView.addArrangedSubview(progressBar8)

        NSLayoutConstraint.activate([
            progressStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            progressStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20)
        ])

        NSLayoutConstraint.activate([
            progressStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            progressStackView.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor),
            progressStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            progressStackView.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor)
        ])

        // controlStackView

        controlStackView.translatesAutoresizingMaskIntoConstraints = false
        controlStackView.alignment = .fill
        controlStackView.spacing = 16
        controlStackView.axis = .horizontal

        controlStackView.addArrangedSubview(resetButton)
        controlStackView.addArrangedSubview(slider)
        controlStackView.addArrangedSubview(setButton)

        NSLayoutConstraint.activate([
            controlStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            controlStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            controlStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }

    private func setupProgressBars() {
        var constraints: [NSLayoutConstraint] = []

        progressStackView.subviews.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false

            constraints.append(view.heightAnchor.constraint(equalToConstant: 20))
        }

        NSLayoutConstraint.activate(constraints)
    }

    private func setupLabels() {
        label1.text = "easeInOut"
        label2.text = "easeIn"
        label3.text = "easeOut"
        label4.text = "spring (damping: 0.8)"
        label5.text = "spring (damping: 0.5"
        label6.text = "spring (damping: 0.2"
        label7.text = "unused"
        label8.text = "unused"
    }

    private func setupButtons() {
        resetButton.setTitle("reset", for: .normal)
        setButton.setTitle("set", for: .normal)

        resetButton.setTitleColor(.red, for: .normal)

        resetButton.addTarget(self, action: #selector(reset), for: .touchUpInside)
        setButton.addTarget(self, action: #selector(set), for: .touchUpInside)
    }

    @objc
    private func reset() {
        progressStackView.subviews.forEach { view in
            if let progressView = view as? ProgressBar {
                progressView.reset()
            }
        }
    }

    @objc
    private func set() {
        reset()

        let value = slider.value

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.progressBar1.setProgress(value, with: .curveEaseInOut)
            self.progressBar2.setProgress(value, with: .curveEaseIn)
            self.progressBar3.setProgress(value, with: .curveEaseOut)
            self.progressBar4.setProgress(value, with: [], damping: 0.8, springVelocity: 5)
            self.progressBar5.setProgress(value, with: [], damping: 0.5, springVelocity: 5)
            self.progressBar6.setProgress(value, with: [], damping: 0.2, springVelocity: 5)
        }
    }
}

